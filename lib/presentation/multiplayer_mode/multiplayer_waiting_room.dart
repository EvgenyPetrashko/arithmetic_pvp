import 'package:arithmetic_pvp/presentation/multiplayer_mode/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../data/models/user.dart';
import '../../data/storage.dart';
import 'multiplayer_game.dart';

class MultiplayerWaitingRoomPage extends StatefulWidget {
  const MultiplayerWaitingRoomPage({Key? key}) : super(key: key);

  @override
  State<MultiplayerWaitingRoomPage> createState() =>
      _MultiplayerWaitingRoomPageState();
}

class _MultiplayerWaitingRoomPageState
    extends State<MultiplayerWaitingRoomPage> {
  List<Profile> profiles = [];
  final Storage _storage = GetIt.instance<Storage>();

  @override
  void initState() {
    super.initState();
    profiles.add(_storage.getProfile('user')!);
    profiles.add(_storage.getProfile('user')!);
  }

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
                MaterialPageRoute(
                  builder: (context) => const MultiplayerGamePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: profiles.length,
          itemBuilder: (BuildContext context, int index) =>
              UserCard(profile: profiles[index]),
        ),
      ),
    );
  }
}
