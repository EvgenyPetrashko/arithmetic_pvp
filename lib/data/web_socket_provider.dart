import 'package:arithmetic_pvp/bloc/events/waiting_room_events.dart';
import 'package:arithmetic_pvp/bloc/events/web_socket_events.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider {
  late final WebSocketChannel webSocketChannel;

  final _url = "";

  final _testUrl = "wss://192.168.31.116:8000/ws";

  WebSocketProvider(){
    webSocketChannel = WebSocketChannel.connect(
      Uri.parse(_url),
    );
  }

  Stream<WebSocketEvent> get webSocketStream => webSocketChannel.stream
      .map((response) => _processServerResponse(response));

  _processServerResponse(response){
    // TODO some processing
    return WaitingRoomEventUsersLoading();
  }

  _submitAnswer(answer){
    webSocketChannel.sink.add(answer);
  }

  _closeSocket() {
    webSocketChannel.sink.close();
  }
}