import 'dart:developer';

import 'package:arithmetic_pvp/data/models/change_name_response.dart';
import 'package:dio/dio.dart';

import '../data/network_client.dart';
import 'models/auth_response.dart';

class Auth {
  NetworkClient client;

  Auth(this.client);

  Future<AuthResponse> socialLogin(String token) async {
    try {
      client.api.options.headers["Authorization"] = "Bearer $token";
      var response = await client.api.post("auth/google_login");
      final cookiesString = response.headers["set-cookie"]?[0].split(";")[0];
      return AuthResponse(cookiesString);
    } on DioError catch (e) {
      log('data: ${e.response}');
      return AuthResponse(null, true);
    }
  }

  Future<ChangeNameResponse> changeUsername(String username) async {
    try {
      var response = await client.api.put("auth/set_new_username/$username");
      return ChangeNameResponse.fromJson(Map<String, dynamic>.from(response.data));
    } on DioError catch (e) {
      log('data ${e.response}');
      return ChangeNameResponse(status: false, error: "Please try again later");
    }
  }
}
