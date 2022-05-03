import 'dart:developer';

import 'package:arithmetic_pvp/data/models/buy_response.dart';
import 'package:arithmetic_pvp/data/models/select_response.dart';
import 'package:arithmetic_pvp/data/models/skin.dart';
import 'package:arithmetic_pvp/data/models/user.dart';
import 'package:arithmetic_pvp/data/network_client.dart';
import 'package:dio/dio.dart';

class Api {
  NetworkClient client;

  Api(this.client);

  Future<List<Skin>> getSkins() async {
    try {
      var response = await client.api.get("api/get_skins");
      return (response.data as List<dynamic>)
          .map((e) => Skin.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioError catch (e) {
      log('data: ${e.response}');
      return [];
    }
  }

  Future<BuyResponse> buySkin(int skinId) async {
    try {
      final response = await client.api
          .put("api/buy_skin/$skinId");
      return BuyResponse.fromJson(Map<String, dynamic>.from(response.data));
    } on DioError catch (e) {
      log('data: ${e.response}');
      return BuyResponse(isSuccess: false,
          report: "Something went wrong, Please try again later.");
    }
  }

  Future<SelectResponse> selectSkin(int skinId) async {
    try {
      final response = await client.api
          .put("api/select_skin/$skinId");
      return SelectResponse.fromJson(Map<String, dynamic>.from(response.data));
    } on DioError catch (e) {
      log('data: ${e.response}');
      return SelectResponse(
          "Something went wrong, Please try again later.", isSuccess: false);
    }
  }

  Future<Profile?> getProfileInfo() async{
    try{
      var response = await client.api.get("api/profile_info");
      return Profile.fromJson(Map<String, dynamic>.from(response.data));
    } on DioError catch(e){
      log('data: ${e.response}');
      return null;
    }
  }
}
