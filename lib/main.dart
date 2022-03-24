import 'package:arithmetic_pvp/login.dart';
import 'package:arithmetic_pvp/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    redirecting();

  }

  void redirecting() async {
    prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("isFirstTime")){
      prefs.setBool("isFirstTime", false);
      // Redirecting to the welcome page
      WidgetsBinding.instance
          ?.addPostFrameCallback((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomePage())));
    }else{
      WidgetsBinding.instance
          ?.addPostFrameCallback((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
          ],
        ),
      ),
    );
  }
}
