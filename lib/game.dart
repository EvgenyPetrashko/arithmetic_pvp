import 'package:arithmetic_pvp/keyboard.dart';
import 'package:flutter/material.dart';


class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final String expression = "2 + 2 = ";
  String ans = '';

  void updateAns(String command) {
    setState(() {
      switch(command) {
        case 'DEL': {
          if (ans.isNotEmpty) {
            ans = ans.substring(0, ans.length - 1);
          }
        }
        break;

        case '-': {
          if (ans.isEmpty){
            ans = '-';
          }
          else{
            if (ans[0] == '-'){
              ans = ans.substring(1);
            }
            else{
              ans = '-' + ans;
            }
          }
        }
        break;

        default: {
          ans = ans + 'command';
        }
        break;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: const Text("Game page",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            margin: const EdgeInsets.only(top: 30, bottom: 40),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  expression,
                  // textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 52, fontWeight: FontWeight.bold),
                ),
                Text(
                  ans,
                  // textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 52, fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   width: 100,
                //   // padding: const EdgeInsets.only(left: 10),
                //   child: (TextField(
                //     decoration: const InputDecoration(
                //       hintText: '123',
                //       border: InputBorder.none,
                //     ),
                //     inputFormatters: [
                //       LengthLimitingTextInputFormatter(3),
                //     ],
                //     style: const TextStyle(
                //         fontSize: 52, fontWeight: FontWeight.bold),
                //     // textAlign: TextAlign.left,
                //   )),
                // ),
              ],
            ),
          ),
          Keyboard(onTap: updateAns),
        ],
      ),
    );
  }
}
