import 'package:arithmetic_pvp/presentation/authentication/login.dart';
import 'package:arithmetic_pvp/presentation/welcome/circular_indicators.dart';
import 'package:arithmetic_pvp/presentation/welcome/welcome_info_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _welcomePageController = PageController();
  final CircularIndicatorController _controller = CircularIndicatorController(0);

  @override
  void initState() {
    super.initState();
    _welcomePageController.addListener(() {
      _controller.pageChange(_welcomePageController.page ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _welcomePageController,
                  children: const [
                    WelcomeInfoPage(
                        text:
                            "Hello there!\nThis is Arithmetic PvP - place of developing your verbal math abilities",
                        assetPath: "assets/dark_logo.svg"),
                    WelcomeInfoPage(
                        text:
                            "Here you can compete with any player and check the power of your mind",
                        assetPath: "assets/thinking.svg"),
                    WelcomeInfoPage(
                        text: "Invite your friends.\nBuy epic skins.\nWin!",
                        assetPath: "assets/celebration.svg"),
                    LoginPage(),
                  ],
                ),
              ),
              CircularIndicators(
                controller: _controller,
                amount: 4
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
