import 'dart:developer';

import 'package:arithmetic_pvp/bloc/auth_bloc.dart';
import 'package:arithmetic_pvp/presentation/authentication/google_button.dart';
import 'package:arithmetic_pvp/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../bloc/events/auth_events.dart';
import '../../bloc/states/auth_states.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authBloc = AuthBloc();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authBloc.add(AuthEventInitial());
  }

  void _handleServerResponse(BuildContext context, AuthState state) {
    bool loadingState = false;
    if (state is AuthStateLoaded) {
      log("Start session");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (Route<dynamic> route) => false);
    } else if (state is AuthStateError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(state.error),
      ));
    } else if (state is AuthStateLoading) {
      loadingState = true;
    }

    log(state.toString());
    if (loadingState != _isLoading) {
      setState(() {
        _isLoading = loadingState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoadingOverlay(
          isLoading: _isLoading,
          progressIndicator: JumpingText(
            '···',
            style: const TextStyle(fontSize: 60),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/dark_logo.svg",
                  height: 128,
                  width: 128,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Arithmetic PvP",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 60,
                ),
                BlocProvider(
                  create: (context) => _authBloc,
                  child: BlocListener<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    listener: (context, state) =>
                        _handleServerResponse(context, state),
                    child: const GoogleButton(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
