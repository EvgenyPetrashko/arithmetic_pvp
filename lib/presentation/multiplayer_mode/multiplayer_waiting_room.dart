import 'package:arithmetic_pvp/presentation/multiplayer_mode/user_card.dart';
import 'package:flutter/material.dart';
import '../../data/models/user.dart';
import 'multiplayer_game.dart';

class MultiplayerWaitingRoomPage extends StatefulWidget {
  const MultiplayerWaitingRoomPage({Key? key}) : super(key: key);

  @override
  State<MultiplayerWaitingRoomPage> createState() =>
      _MultiplayerWaitingRoomPageState();
}

class _MultiplayerWaitingRoomPageState
    extends State<MultiplayerWaitingRoomPage> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waiting Room'),
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MultiplayerGamePage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) => UserCard(user: users[index])),
      ),
    );
  }
}
