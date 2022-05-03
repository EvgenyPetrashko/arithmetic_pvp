import 'package:dio/dio.dart';

class NetworkClient {
  final _baseUrl = "https://arithmetic-pvp-backend.herokuapp.com/";
  final _baseUrlTest = "http://192.168.31.116:8000/";
  late Dio api;

  NetworkClient() {
    api = Dio(BaseOptions(baseUrl: _baseUrl));
  }
}
