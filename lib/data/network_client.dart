import 'package:arithmetic_pvp/data/auth_interceptor.dart';
import 'package:dio/dio.dart';

class NetworkClient {
  final _baseUrl = "https://arithmetic-pvp-backend.herokuapp.com/";
  final _baseUrlTest = "http://192.168.31.124:8000/";
  late Dio api;

  NetworkClient(AuthInterceptor _authInterceptor) {
    api = Dio(BaseOptions(baseUrl: _baseUrlTest));
    api.interceptors
      ..clear()
      ..add(_authInterceptor);
  }
}
