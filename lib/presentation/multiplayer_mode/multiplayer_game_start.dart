import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

import '../utils/rain_particles.dart';
import 'multiplayer_waiting_room.dart';

class MultiplayerGameStartPage extends StatefulWidget {
  const MultiplayerGameStartPage({Key? key}) : super(key: key);

  @override
  State<MultiplayerGameStartPage> createState() =>
      _MultiplayerGameStartPageState();
}

class _MultiplayerGameStartPageState extends State<MultiplayerGameStartPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: RainParticleBehaviour(
        options: ParticleOptions(
          baseColor: Theme.of(context).primaryColor,
          spawnOpacity: 0.0,
          opacityChangeRate: 0.25,
          minOpacity: 0.1,
          maxOpacity: 1,
          particleCount: 70,
          spawnMaxRadius: 3.0,
          spawnMinRadius: 1.0,
          spawnMaxSpeed: 100.0,
          spawnMinSpeed: 30,
        ),
      ),
      vsync: this,
      child: Container(
        alignment: Alignment.center,
        child: Ink.image(
          image: const svg_provider.Svg('assets/start_game.svg'),
          width: 150,
          height: 150,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MultiplayerWaitingRoomPage()),
              );
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}
