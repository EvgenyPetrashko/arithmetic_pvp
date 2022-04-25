import 'package:arithmetic_pvp/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends StatefulWidget{
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();

}

class _WelcomePageState extends State<WelcomePage>{
  final PageController _welcomePageController = PageController();
  final _keysList = [GlobalKey<_ColoredCircleState>(), GlobalKey<_ColoredCircleState>(), GlobalKey<_ColoredCircleState>(), GlobalKey<_ColoredCircleState>()];


  @override
  void initState() {
    super.initState();
    // change circles color on page swap
    _welcomePageController.addListener(() {
      var pageValue = _welcomePageController.page ?? 0;
      if ((pageValue < 0.70) || (pageValue >= 0.70 && pageValue < 1.70) || (pageValue >= 1.70 && pageValue < 2.70) || (pageValue >= 2.70)){
        for (var i = 0; i < _keysList.length; i++){
          var intPageValue = pageValue.round();
          if (intPageValue == i){
            _keysList[i].currentState!.changeColor(Colors.blue);
          }else{
            _keysList[i].currentState!.changeColor(Colors.grey);
          }
        }
      }
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
                  child:
                  PageView(
                    controller: _welcomePageController,
                    children: const [
                      WelcomeInfoPage(text: "Hello, my friend!\nThis is Arithmetic PvP - place of growing your verbal math abilities", assetPath: "assets/dark_logo.svg"),
                      WelcomeInfoPage(text: "Here you can compete with any player and check the power of your brain", assetPath: "assets/thinking.svg"),
                      WelcomeInfoPage(text: "Invite your friends.\nBuy epic skins.\nWin!", assetPath: "assets/celebration.svg"),
                      LoginPage()
                    ],
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColoredCircle(key: _keysList[0], color: Colors.blue,),
                  const SizedBox(width: 5),
                  ColoredCircle(key: _keysList[1],),
                  const SizedBox(width: 5,),
                  ColoredCircle(key: _keysList[2],),
                  const SizedBox(width: 5,),
                  ColoredCircle(key: _keysList[3],)
                ],
              ),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      )
    );
  }

}

class WelcomeInfoPage extends StatelessWidget{
  const WelcomeInfoPage({Key? key, required this.text, required this.assetPath}) : super(key: key);

  final String text;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(assetPath, height: 128, width: 128),
        const SizedBox(height: 100),
        SizedBox(
          width: 200,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16.00,
                fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic
            )
          )
        ),
      ],
    );
  }

}


class ColoredCircle extends StatefulWidget{

  const ColoredCircle({Key? key, this.color = Colors.grey}) : super(key: key);

  final Color color;
  @override
  State<ColoredCircle> createState() => _ColoredCircleState();

}

class _ColoredCircleState extends State<ColoredCircle>{

  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
      ),
    );
  }


  changeColor(Color givenColor){
    setState(() {
      _color = givenColor;
    });
  }

}