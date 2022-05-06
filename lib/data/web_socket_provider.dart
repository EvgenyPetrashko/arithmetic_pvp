import 'package:arithmetic_pvp/bloc/events/waiting_room_events.dart';
import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider {
  late final WebSocketChannel webSocketChannel;

  WebSocketProvider(int roomId, headers) {
    final _url = "ws://arithmetic-pvp-backend.herokuapp.com/ws/rating_room/$roomId/";

    final _testUrl = "ws://192.168.31.116:8000/ws/rating_room/$roomId/";

    webSocketChannel =
        IOWebSocketChannel.connect(Uri.parse(_testUrl), headers: headers);
  }

  Stream<WebSocketEvent> get webSocketStream => webSocketChannel.stream
      .map((response) => _processServerResponse(response));

  _processServerResponse(response) {
    // TODO some processing
    print(response);
    return WaitingRoomEventUsersLoading([]);
  }

  _submitAnswer(answer) {
    webSocketChannel.sink.add(answer);
  }

  _closeSocket() {
    webSocketChannel.sink.close();
  }
}
