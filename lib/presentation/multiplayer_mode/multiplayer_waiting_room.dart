import 'package:flutter/material.dart';
import 'multiplayer_game.dart';

class MultiplayerWaitingRoomPage extends StatefulWidget {
  const MultiplayerWaitingRoomPage({Key? key}) : super(key: key);

  @override
  State<MultiplayerWaitingRoomPage> createState() =>
      _MultiplayerWaitingRoomPageState();
}

class _MultiplayerWaitingRoomPageState
    extends State<MultiplayerWaitingRoomPage> {
  List<String> users = ["DIMbI4", "TroHaN", "KamilAin", "gfx"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting Room'),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(users[index]);
            }),
      ),
    );
  }
}
