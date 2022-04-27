import 'package:dio/dio.dart';
import 'dart:developer';
import '../data/auth_response.dart';
import '../data/network_client.dart';


class Auth{
  NetworkClient client;
  Auth(this.client);

  Future<AuthResponse> socialLogin(String token) async{
    try{
      client.api.options.headers["Authorization"] = "Bearer $token";
      var response = await client.api.post("auth/google_login");
      return AuthResponse(response.headers["set-cookie"]?[0]);
    }on DioError catch (e){
      log('data: ${e.response}');
      return AuthResponse(null, true);
    }
  }
  
  Future<Map<String, String>> getUserInfo() async{
    try{
      var response = await client.api.post("auth/profile_info");
      print(response);
      return Map.from(response.data);
    } on DioError catch(e){
      return Map<String, String>.from(e.response?.data);
    }
  }

}