import 'dart:async';
import 'package:arithmetic_pvp/data/web_socket_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late WebSocketProvider webSocketProvider;

  test('Web Socket Connection', () {
    webSocketProvider = WebSocketProvider(26, {
      "Test-Name": "TroHaN3",
      "Test-Email": "e.petrashko21@gmail.com",
    });
    webSocketProvider.webSocketStream
        .listen(expectAsync1((value) => print(value)));
  });

  test("Test time converter", () {
    (DateTime.now().millisecondsSinceEpoch / 1000).round();
    var date = DateTime.parse("2022-05-05T20:15:50.627236Z");
    print((date.millisecondsSinceEpoch / 1000).round());
  });

  test('Test streams', () {
    final stream1 = StreamController<int>.broadcast();
    final StreamSubscription sub1 = stream1.stream.listen((event) {
      // Do some things1
    });

    sub1.cancel();

    final StreamSubscription sub2 = stream1.stream.listen((event) {
      // Do some things2
    });
  });

  test('Test socket getTasks', () async {
    final headers = {
      "Test-Name": "TroHaN21",
      "Test-Email": "e.petrashko12@gmail.com",
    };
    final _dio = Dio(BaseOptions(
      headers: headers,
    ));
    final response = await _dio.post("http://192.168.31.116:8000/api/create_rating_room");
    final json = Map<String, dynamic>.from(response.data);
    final roomId = json["id"];

    print("Sleep 3 seconds");
    await Future.delayed(const Duration(seconds: 3));
    final provider = WebSocketProvider(roomId, headers, true);
    final webSocketStream = provider.webSocketStream;

    final secondsToSleep = ((DateTime.parse(json["start_time"]).millisecondsSinceEpoch /
        1000) -
        (DateTime.now().millisecondsSinceEpoch / 1000))
        .round() + 3;

    print("Sleep $secondsToSleep seconds");
    await Future.delayed(Duration(seconds: secondsToSleep));
    provider.getTasks();
    print("getTasks was send");
    print(provider.webSocketChannel.closeCode);

    webSocketStream.listen(
        expectAsync1((value) => print(value.toString()))
    );



  });
}
