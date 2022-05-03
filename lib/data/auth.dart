import 'dart:developer';

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
      return AuthResponse(response.headers["set-cookie"]?[0]);
    } on DioError catch (e) {
      log('data: ${e.response}');
      return AuthResponse(null, true);
    }
  }

  Future<bool?> checkUsernameIsAvailable(String username) async {
    try {
      // check if username is available on server
      return false;
    } on DioError catch (e) {
      log('data ${e.response}');
      return null;
    }
  }
}
