
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


  test('Register testing', () async {
    var responseMap = await authApi.register("Evgeny123", "e.petrashko@innopolis.university", "kfdskfdfslk");
    print(responseMap);
  });

  test("Login testing", () async {
    var tokens = await authApi.login("Qwerty1234", "Qwerty1234");
    print(tokens);
  });


}