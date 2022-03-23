import 'package:arithmetic_pvp/logic/network_client.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';


class Auth{
  NetworkClient client;
  Auth(this.client);
  
  String _encodePassword(String pw){
    var key = utf8.encode('p@ssw0rd');
    var bytes = utf8.encode(pw);

    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    return digest.toString();
  }

  Future<Map<String, bool>> register(String username, String email, String password) async {
    try {
      var response = await client.getApi().post("api/v1/users/",
          data: jsonEncode({"username": username, "email": email, "password": _encodePassword(password)}));
      print(response);
    } on DioError catch (e) {
      var strStatusCode = e.response?.statusCode.toString() ?? "0";
      if (strStatusCode == "400"){
        var m = Map<String, dynamic>.from(e.response?.data);
        return {m.values.first[0] as String: false};
      }else if (strStatusCode.startsWith("5")){
        return {"Server is currently unnavalible": false};
      }
      return {"Failure": false};
    }
    return {"Success": true};
  }

  Future<Map<String, String>> login(String username, String password) async {
    try {
      var response = await client.getApi().post("api/v1/jwt/create/",
          data: jsonEncode({"username": username, "password": _encodePassword(password)}));
      return {"refresh": response.data["refresh"], "access": response.data["access"]};
    } catch (e) {
      print(e);
      return {};
    }
  }

}