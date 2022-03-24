import 'package:arithmetic_pvp/logic/network_client.dart';
import 'package:arithmetic_pvp/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'logic/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  bool _passwordObscure = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late Auth authClient;

  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authClient = Auth(NetworkClient());
  }

  bool _isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
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
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: Form(
                      key: _registerFormKey,
                      child: Column(
                        children: [
                          // Username/Nickname
                          TextFormField(
                            controller: _usernameController,
                            validator: (value) {
                              // some  nickname validation
                              if (value == null || value.isEmpty) {
                                return "Enter your username";
                              } else if (value.length < 6) {
                                return "Your username must contain at least 6 characters";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "Username",
                                border: OutlineInputBorder(),
                                hintText: "Nagibator228",
                                fillColor: Color(0xFFE2E1E1),
                                filled: true),
                          ),
                          // Mail
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              // some email validation
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!_isEmailValid(value)) {
                                return 'Wrong email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: "E-Mail",
                                border: OutlineInputBorder(),
                                hintText: "nagibator228@gmail.com",
                                fillColor: Color(0xFFE2E1E1),
                                filled: true),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _passwordObscure,
                            decoration: InputDecoration(
                                labelText: "Password",
                                border: const OutlineInputBorder(),
                                fillColor: const Color(0xFFE2E1E1),
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(_passwordObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _passwordObscure = !_passwordObscure;
                                    });
                                  },
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your password";
                              } else if (!_isPasswordValid(value)) {
                                return "Password must contain at least\n1 lower case char, 1 upper case char,\n1 number and be at least 8 char long";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (_registerFormKey.currentState!.validate()) {
                                  if (!_isLoading) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    var responseMap = await authClient.register(
                                        _usernameController.text,
                                        _emailController.text,
                                        _passwordController.text);
                                    var report = responseMap.keys.first;
                                    var status = responseMap[report] ?? false;
                                    if (status) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const LoginPage()));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(report)),
                                      );
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 15),
                              ),
                              child: const Text(
                                "Register",
                                style: TextStyle(fontSize: 18),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text("Do you already have an account?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LoginPage()));
                              },
                              child: const Text("Login"))
                        ],
                      ),
                    ),
                    width: 300,
                  )
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
