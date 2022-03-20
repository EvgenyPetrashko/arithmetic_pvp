import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget{

  @override
  State<RegisterPage> createState() =>  _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  final _registerFormKey = GlobalKey<FormState>();

  bool _passwordObscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/dark_logo.svg", height: 180, width: 180,),
                const SizedBox(height: 10,),
                const Text("Arithmetic PvP", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                const SizedBox(height: 40,),
                const Text("Register", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                const SizedBox(height: 20,),
                SizedBox(
                  child: Form(
                    key: _registerFormKey,
                    child: Column(
                      children: [
                        // Username/Nickname
                        TextFormField(
                          validator: (value){
                            // some  nickname validation
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Username",
                              border: OutlineInputBorder(),
                              hintText: "Nagibator228",
                              fillColor: Color(0xFFE2E1E1),
                              filled: true
                          ),
                        ),
                        // Mail
                        const SizedBox(height: 20,),
                        TextFormField(
                          validator: (value){
                            // some email validation

                          },
                          decoration: const InputDecoration(
                              labelText: "E-Mail",
                              border: OutlineInputBorder(),
                              hintText: "nagibator228@gmail.com",
                              fillColor: Color(0xFFE2E1E1),
                              filled: true
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          obscureText: _passwordObscure,
                          decoration: InputDecoration(
                              labelText: "Password",
                              border: const OutlineInputBorder(),
                              fillColor: Color(0xFFE2E1E1),
                              filled: true,
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _passwordObscure ? Icons.visibility : Icons.visibility_off
                                ),
                                onPressed: (){
                                  setState(() {
                                    _passwordObscure = !_passwordObscure;
                                  });
                                },
                              )
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ElevatedButton(onPressed: () {}, child: const Text("Register", style: TextStyle(fontSize: 18),)),
                        const SizedBox(height: 30,),
                        const Text("Do you already have an account?"),
                        TextButton(onPressed: (){}, child: const Text("Login"))
                      ],
                    ),
                  ),
                  width: 300,

                )

              ],
            ),
          )
      )
    );
  }
}