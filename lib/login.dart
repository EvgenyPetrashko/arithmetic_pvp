import 'package:arithmetic_pvp/logic/network_client.dart';
import 'package:arithmetic_pvp/main.dart';
import 'package:arithmetic_pvp/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logic/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _registerFormKey = GlobalKey<FormState>();

  bool _passwordObscure = true;

  bool _submitBtnDisabled = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late Auth auth_client;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    auth_client = Auth(NetworkClient());
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
                  height: 40,
                ),
                const Text(
                  "Sign In",
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
                          controller: _passwordController,
                          obscureText: _passwordObscure,
                          decoration: InputDecoration(
                              labelText: "Password",
                              border: const OutlineInputBorder(),
                              fillColor: Color(0xFFE2E1E1),
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
                                if (!_submitBtnDisabled) {
                                  _submitBtnDisabled = true;
                                  var responseMap = await auth_client.login(
                                      _usernameController.text,
                                      _passwordController.text);
                                  var reportMap = responseMap.keys.first;
                                  var status = responseMap[reportMap] ?? false;
                                  if (status) {
                                    prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setString(
                                        'refresh', reportMap["refresh"] ?? "");
                                    await prefs.setString(
                                        "access", reportMap["access"] ?? "");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              reportMap["error"] ?? "Error")),
                                    );
                                  }
                                  _submitBtnDisabled = false;
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 15),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Still don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: const Text("Register")),
                      ],
                    ),
                  ),
                  width: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
