import 'package:arithmetic_pvp/presentation/authentication/login.dart';
import 'package:arithmetic_pvp/presentation/home.dart';
import 'package:arithmetic_pvp/data/auth.dart';
import 'package:arithmetic_pvp/data/network_client.dart';
import 'package:arithmetic_pvp/data/storage.dart';
import 'package:arithmetic_pvp/presentation/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


void main() {
  setUp();
  runApp(const MyApp());
}

void setUp() {
  final getIt = GetIt.instance;
  getIt.registerSingleton(NetworkClient());
  getIt.registerSingleton<Auth>(Auth(getIt.get<NetworkClient>()));
  Storage storage = Storage();
  getIt.registerSingletonAsync(() => storage.init());
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


  @override
  void initState() {
    super.initState();
    redirecting();
  }

  void redirecting() async {
    await GetIt.instance.allReady();
    if (!_storage.containKey("isFirstTime")){
      _storage.setBool("isFirstTime", false);
      // Redirecting to the welcome page
      WidgetsBinding.instance
          .addPostFrameCallback((_) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomePage())));
    }else{
      if (_storage.containKey("cookie")){
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      )
    );
  }
}
