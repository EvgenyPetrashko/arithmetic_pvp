import 'package:arithmetic_pvp/logic/auth.dart';
import 'package:arithmetic_pvp/logic/network_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  NetworkClient client;
  late Auth authApi;

  setUp((){
    client = NetworkClient();
    authApi = Auth(client);
  });



}