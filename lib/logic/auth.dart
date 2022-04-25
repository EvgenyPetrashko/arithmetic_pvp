import 'package:arithmetic_pvp/logic/network_client.dart';
import 'package:dio/dio.dart';


class Auth{
  NetworkClient client;
  Auth(this.client);

  Future<String?> socialLogin(String token) async{
    try{
      client.getTestApi().options.headers["Authorization"] = "Bearer $token";
      var response = await client.getTestApi().post("auth/google_login");
      return response.headers["set-cookie"]?[0];
    }on DioError catch (e){
      var m = Map<String, dynamic>.from(e.response?.data);
      print(m);
      return null;
    }
  }
  
  Future<Map<String, String>> getUserInfo() async{
    try{
      var response = await client.getTestApi().post("auth/profile_info");
      return Map.from(response.data);
    } on DioError catch(e){
      return Map<String, String>.from(e.response?.data);
    }
  }

}