import 'package:arithmetic_pvp/bloc/events/main_events.dart';
import 'package:arithmetic_pvp/bloc/states/main_states.dart';
import 'package:arithmetic_pvp/presentation/authentication/login.dart';
import 'package:arithmetic_pvp/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/bloc_main.dart';

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
  final _mainBloc = MainBloc();
  static const _animationTimeSeconds = 2;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: _animationTimeSeconds),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async => {
          // wait for animation to complete
          await Future.delayed(
              const Duration(seconds: _animationTimeSeconds * 1), () {}),
          _mainBloc.add(MainUserEventStartLoading())
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void redirecting(BuildContext context, MainState state) {
    if (state is MainStateLoaded) {
      late Widget _redirectedWidget;
      if (state.isLoginnedIn) {
        _redirectedWidget = const HomePage();
      } else {
        // Only for testing / bypass login
        _redirectedWidget = const LoginPage();
        // _redirectedWidget = const HomePage();
      }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => _redirectedWidget,
          ),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => _mainBloc,
        child: BlocListener<MainBloc, MainState>(
          listener: (context, state) => redirecting(context, state),
          child: Center(
            child: ScaleTransition(
              scale: _animation,
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
