import 'package:animated_background/animated_background.dart';
import 'dart:developer';
import 'package:arithmetic_pvp/bloc/multiplayer_game_start_bloc.dart';
import 'package:arithmetic_pvp/bloc/states/multiplayer_game_start_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../bloc/events/multiplayer_game_start_events.dart';
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
  final MultiplayerGameStartBloc _multiplayerGameStartBloc =
      MultiplayerGameStartBloc();

  _handleState(context, state) {
    log(state.toString());
    if (state is MultiplayerGameStartStateError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
        ),
      );
    } else if (state is MultiplayerGameStartStateLoaded) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_context) => MultiplayerWaitingRoomPage(
                  joinRoomResponse: state.joinGameResponse)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _multiplayerGameStartBloc,
        listener: (context, state) => _handleState(context, state),
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: (state is MultiplayerGameStartStateLoading),
            child: AnimatedBackground(
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
                    onTap: (state is! MultiplayerGameStartStateLoading)
                        ? () {
                            _multiplayerGameStartBloc
                                .add(MultiplayerGameStartEvent());
                          }
                        : null,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
