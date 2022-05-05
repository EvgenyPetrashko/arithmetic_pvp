import 'dart:developer';

import 'package:arithmetic_pvp/data/storage.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/cookie.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Storage _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final sessionToken = _storage.getCookie("cookie")?.sessionToken;
    if (sessionToken != null) {
      options.headers["cookie"] = _storage.getCookie("cookie")?.sessionToken;
    }
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log("Interceptor handles the error");
    if (err.response?.statusCode == 403) {
      final _dio = Dio(
        BaseOptions(baseUrl: err.requestOptions.baseUrl),
      );
      final _storageCookie = _storage.getCookie("cookie");
      if (_storageCookie != null &&
          (_storageCookie.lastRefreshTime + (3 * 3600 * 24 * 1)) >
              (DateTime.now().millisecondsSinceEpoch / 1000).round()) {
        _dio.options.headers["cookie"] = _storageCookie.sessionToken;
        return handler.resolve(await _dio.request(err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters));
      }
      User? user = FirebaseAuth.instance.currentUser;
      String? token = await user?.getIdToken();
      if (token != null) {
        _dio.options.headers["Authorization"] = "Bearer $token";
        try {
          final response = await _dio.post("auth/google_login");
          if (err.requestOptions.path == "auth/google_login") {
            return handler.resolve(response);
          }
          final cookies = response.headers["set-cookie"]?[0].split(";")[0];
          if (cookies != null) {
            log("Cookies refreshed");
            _dio.options.headers["cookie"] = cookies;
            _storage.setCookie(
                "cookie",
                Cookie(cookies,
                    (DateTime.now().millisecondsSinceEpoch / 1000).round()));
            _dio.options.headers.remove("Authorization");
            return handler.resolve(await _dio.request(err.requestOptions.path,
                data: err.requestOptions.data,
                options: Options(headers: _dio.options.headers),
                queryParameters: err.requestOptions.queryParameters));
          }
        } on DioError catch (e) {
          log('data in Interceptor: ${e.response}');
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }
}
