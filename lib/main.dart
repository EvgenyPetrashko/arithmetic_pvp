import 'dart:developer';

import 'package:arithmetic_pvp/bloc/events/main_events.dart';
import 'package:arithmetic_pvp/bloc/states/main_states.dart';
import 'package:arithmetic_pvp/presentation/authentication/login.dart';
import 'package:arithmetic_pvp/presentation/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import 'bloc/main_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    final _mainBloc = MainBloc();
    return BlocProvider(
      create: (context) => _mainBloc,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.deepPurpleAccent,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff70ABE2),
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
              appBarTheme: const AppBarTheme(
                  // color: Color(0xff525252),
                  color: Colors.blueGrey),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.amber,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff424242),
                  textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            themeMode: currentMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late MainBloc _mainBloc;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _mainBloc = BlocProvider.of<MainBloc>(context);
    const _animationTimeSeconds = 2;

    _controller = AnimationController(
      duration: const Duration(seconds: _animationTimeSeconds),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    WidgetsBinding.instance?.addPostFrameCallback((_) async => {
          // wait for animation to complete
          await Future.delayed(
              const Duration(seconds: _animationTimeSeconds * 1), () {}),
          _mainBloc.add(SplashScreenEventStartLoading())
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void redirecting(BuildContext context, MainState state) {
    log(state.toString());
    if (state is MainStateLoaded) {
      late Widget _redirectedWidget;
      if (state.isLoginnedIn) {
        _redirectedWidget = const HomePage();
      } else {
        _redirectedWidget = const LoginPage();
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
      body: BlocListener<MainBloc, MainState>(
        bloc: _mainBloc,
        listener: (context, state) => redirecting(context, state),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyApp.themeNotifier.value == ThemeMode.light ? SvgPicture.asset(
                  "assets/dark_logo.svg",
                  height: 128,
                  width: 128,
                ) : SvgPicture.asset(
                  "assets/light_logo.svg",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
