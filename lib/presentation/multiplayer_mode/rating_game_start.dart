import 'dart:developer';

import 'package:animated_background/animated_background.dart';
import 'package:arithmetic_pvp/bloc/rating_room_start_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;
import 'package:loading_overlay/loading_overlay.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../bloc/events/rating_room_start_events.dart';
import '../../bloc/states/rating_room_start_states.dart';
import '../utils/rain_particles.dart';
import 'rating_waiting_room.dart';

class MultiplayerGameStartPage extends StatefulWidget {
  const MultiplayerGameStartPage({Key? key}) : super(key: key);

  @override
  State<MultiplayerGameStartPage> createState() =>
      _MultiplayerGameStartPageState();
}

class _MultiplayerGameStartPageState extends State<MultiplayerGameStartPage>
    with TickerProviderStateMixin {
  final RatingRoomStartBloc _multiplayerGameStartBloc = RatingRoomStartBloc();

  _handleState(context, state) {
    log(state.toString());
    if (state is RatingRoomStartStateError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.error),
        ),
      );
    } else if (state is RatingRoomStartStateLoaded) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_context) => MultiplayerWaitingRoomPage(
                  joinRoomResponse: state.joinRoomResponse)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _multiplayerGameStartBloc,
        listener: (context, state) => _handleState(context, state),
        builder: (context, state) {
          return LoadingOverlay(
            progressIndicator: JumpingText(
              "...",
              style: const TextStyle(fontSize: 60),
            ),
            color: Colors.black45,
            isLoading: (state is RatingRoomStartStateLoading),
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
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Ink.image(
                  image: const svg_provider.Svg('assets/start_game.svg'),
                  width: 150,
                  height: 150,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: (state is! RatingRoomStartStateLoading)
                        ? () {
                            _multiplayerGameStartBloc
                                .add(RatingRoomStartEvent());
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
