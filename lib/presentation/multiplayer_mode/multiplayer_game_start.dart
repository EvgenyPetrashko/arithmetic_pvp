import 'package:flutter/material.dart';

import 'multiplayer_waiting_room.dart';

class MultiplayerGameStartPage extends StatelessWidget {
  const MultiplayerGameStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: () {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => const MultiplayerGamePage()),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MultiplayerWaitingRoomPage()),
          );
        },
        child: const Text('Start Rating Game'),
      ),
    );
  }
}
