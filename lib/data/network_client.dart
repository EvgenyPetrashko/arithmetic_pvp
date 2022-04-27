import 'package:dio/dio.dart';

class NetworkClient{
  final baseUrl = "https://arithmetic-pvp-backend.herokuapp.com/";
  final baseUrlTest = "http://192.168.31.116:8000/";
  late Dio api;

  NetworkClient(){
    api = Dio(BaseOptions(baseUrl: baseUrl));
  }
}