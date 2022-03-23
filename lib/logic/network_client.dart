import 'package:dio/dio.dart';

class NetworkClient{
  final _dio = Dio(BaseOptions(baseUrl: "https://arithmetic-pvp-backend.herokuapp.com/"));

  Dio getApi(){
    return _dio;
  }
}