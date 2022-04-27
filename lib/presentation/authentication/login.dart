import 'package:arithmetic_pvp/bloc/auth_bloc.dart';
import 'package:arithmetic_pvp/presentation/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthBloc _authBloc = AuthBloc();

  var _isLoading = false;

  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credentials);
    } else {
      _authBloc.add(AuthUserEventCancel(""));
    }
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
        _authBloc.add(AuthUserEventCancel(""));
      }
    });
  }

  void _handleServerResponse(BuildContext context, AuthState state) {
    bool loadingState = false;
    if (state is AuthStateLoaded) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (Route<dynamic> route) => false);
      loadingState = false;
    } else if (state is AuthStateError) {
      log("Error ${state.error}");
      loadingState = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(state.error),
      ));
    } else if (state is AuthStateLoading) {
      loadingState = true;
    } else if (state is AuthStateInitial) {
      loadingState = false;
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
      body: LoadingOverlay(
        color: Colors.grey,
        progressIndicator: const CircularProgressIndicator(
          color: Colors.black,
        ),
        child: SafeArea(
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
                    height: 40,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocProvider(
                    create: (BuildContext context) => _authBloc,
                    child: BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) =>
                          _handleServerResponse(context, state),
                      child: Container(),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      _authBloc.add(AuthUserEventStartLoading(""));
                      await googleSignIn();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/google_icon.png",
                            width: 32,
                            height: 32,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading: _isLoading,
      ),
    );
  }
}
