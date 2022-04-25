import 'package:arithmetic_pvp/home.dart';
import 'package:arithmetic_pvp/logic/network_client.dart';
import 'package:arithmetic_pvp/logic/storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../logic/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Auth authClient;
  final Storage _storage = Storage();

  var _isLoading = false;

  @override
  void initState() {
    initializeFirebase();
    super.initState();
    authClient = Auth(NetworkClient());
    _storage.init();
  }

  Future<UserCredential> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }

  void initializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        var token = await user.getIdToken();
        var cookie = await authClient.socialLogin(token);
        print("Cookie: $cookie");
        if (cookie != null) {
          _storage.setString("cookie", cookie);
          // Navigator.of(context).popUntil((route) => false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Authentication error'),
          ));
        }
        setState(() {
          _isLoading = false;
        });
      }
    });
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
                  /*const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
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
