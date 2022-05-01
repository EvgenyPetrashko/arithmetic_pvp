import 'dart:convert';
import 'dart:developer';

import 'package:arithmetic_pvp/data/models/buy_response.dart';
import 'package:arithmetic_pvp/data/models/skin.dart';
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
      var response = await client.api
          .post("api/buy_skin", data: jsonEncode({"skin_id": skinId}));
      return BuyResponse(jsonDecode(response.data)["status"], null);
    } on DioError catch (e) {
      log('data: ${e.response}');
      return BuyResponse(
          false, "Something went wrong, Please try again later.");
    }
  }
}
