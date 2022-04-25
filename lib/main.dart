import 'package:arithmetic_pvp/authentication/login.dart';
import 'package:arithmetic_pvp/home.dart';
import 'package:arithmetic_pvp/logic/storage.dart';
import 'package:arithmetic_pvp/welcome_screen.dart';
import 'package:flutter/material.dart';


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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  final Storage _storage = Storage();

  late AnimationController controller;

  @override
  void initState() {
    _storage.init();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller.repeat();
    redirecting();
    super.initState();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void redirecting() async {
    if (!await _storage.containKey("isFirstTime")){
      await _storage.setBool("isFirstTime", false);
      // Redirecting to the welcome page
      WidgetsBinding.instance
          .addPostFrameCallback((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomePage())));
    }else{
      if (await _storage.containKey("cookie")){
        // if we have access token in our sp:
        // for now: Redirecting to the home page
        WidgetsBinding.instance
            .addPostFrameCallback((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())));
        // TODO : check if token is still valid (api call, for example: request profile info)

      }else{
        // Redirecting to the login page
        WidgetsBinding.instance
            .addPostFrameCallback((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          value: controller.value,
          semanticsLabel: 'Linear progress indicator',
        ),
      )
    );
  }
}
