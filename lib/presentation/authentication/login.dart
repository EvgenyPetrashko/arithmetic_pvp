import 'package:arithmetic_pvp/bloc/auth_bloc.dart';
import 'package:arithmetic_pvp/presentation/authentication/google_button.dart';
import 'package:arithmetic_pvp/presentation/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer';

import '../../bloc/events/auth_events.dart';
import '../../bloc/states/auth_states.dart';
import '../utils/loading_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc _authBloc = AuthBloc();

  var _isLoading = false;

  _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: const [
              CircularProgressIndicator.adaptive(),
              SizedBox(
                height: 10,
              ),
              LoadingText(inputText: "Loading"),
            ]),
          );
        });
  }

  _closeLoading() {
    log("Closing the dialog");
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  void initializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        log("User is signed in!");
        var token = await user.getIdToken();
        log("token $token");
        _authBloc.add(AuthUserEventLoad(token));
      } else {
        _authBloc.add(AuthUserEventCancel());
      }
    });
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
        if (loadingState == true) {
          _showLoading();
        } else {
          _closeLoading();
        }
        _isLoading = loadingState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                  create: (BuildContext context) => _authBloc,
                  child: BlocListener<AuthBloc, AuthState>(
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
