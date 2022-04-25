import 'package:dio/dio.dart';

class NetworkClient{
  final _dio = Dio(BaseOptions(baseUrl: "https://arithmetic-pvp-backend.herokuapp.com/"));
  final _dioTest = Dio(BaseOptions(baseUrl: "http://192.168.31.116:8000/"));

  NetworkClient([String? cookie]){
    if (cookie != null){
      _dio.options.headers["cookie"] = cookie;
      _dioTest.options.headers["cookie"] = cookie;
    }
  }

  Dio getApi(){
    return _dio;
  }

  Dio getTestApi(){
    return _dioTest;
  }
}