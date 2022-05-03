import 'package:arithmetic_pvp/presentation/multiplayer_mode/keyboard.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/progress_bar.dart';
import 'package:flutter/material.dart';

class MultiplayerGamePage extends StatefulWidget {
  const MultiplayerGamePage({Key? key}) : super(key: key);

  @override
  State<MultiplayerGamePage> createState() => _MultiplayerGamePageState();
}

class _MultiplayerGamePageState extends State<MultiplayerGamePage> {
  final String expression = "2 + 2";
  String ans = '_ _';

  void updateAns(String command) {
    setState(() {
      switch (command) {
        case 'DEL':
          {
            if (ans.isNotEmpty) {
              ans = ans.substring(0, ans.length - 1);
            }
          }
          break;

        case '-':
          {
            if (ans.isEmpty) {
              ans = '-';
            } else {
              if (ans[0] == '-') {
                ans = ans.substring(1);
              } else {
                ans = '-' + ans;
              }
            }
          }
          break;

        default:
          {
            ans = ans + command;
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Game'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 20,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    UserProgress(username: 'DIMbI4', value: 1),
                    UserProgress(username: 'TroHaN', value: 0.5),
                    UserProgress(username: 'KamilAin', value: 0.8),
                    UserProgress(username: 'gfx', value: 0.3),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 35,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 55,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        expression,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: const Text(
                        '=',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 35,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        ans,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 45,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Keyboard(
                  onTap: updateAns,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
