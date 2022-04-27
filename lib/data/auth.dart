import 'package:dio/dio.dart';
import 'dart:developer';
import 'models/auth_response.dart';
import '../data/network_client.dart';
import 'models/user.dart';


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
  
  Future<User?> getUserInfo() async{
    try{
      var response = await client.api.get("auth/profile_info");
      return User.fromJson(Map<String, dynamic>.from(response.data));
    } on DioError catch(e){
      log('data: ${e.response}');
      return null;
    }
  }

}