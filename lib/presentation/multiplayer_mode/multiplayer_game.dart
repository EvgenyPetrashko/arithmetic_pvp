import 'package:animated_background/animated_background.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/keyboard.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/progress_bar.dart';
import 'package:flutter/material.dart';

import '../stats/stats_postgame.dart';

class MultiplayerGamePage extends StatefulWidget {
  const MultiplayerGamePage({Key? key}) : super(key: key);

  @override
  State<MultiplayerGamePage> createState() => _MultiplayerGamePageState();
}

class _MultiplayerGamePageState extends State<MultiplayerGamePage>
    with SingleTickerProviderStateMixin {
  final String expression = "2 + 2";
  String ans = '';

  void updateAns(String command) {
    setState(
      () {
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
      },
    );
  }

  double _counter = 0;

  void _setCounter(double x) {
    setState(() {
      _counter = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Game'),
        actions: [
          TextButton(
            child: const Text(
              'Finish',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostgameStatsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedBackground(
          behaviour:
              RacingLinesBehaviour(numLines: 5, direction: LineDirection.Ltr),
          vsync: this,
          child: Column(
            children: [
              Expanded(
                flex: 20,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      UserProgress(
                          username: 'Aidar Khuzin',
                          value: _counter,
                          color: Colors.redAccent),
                      UserProgress(
                          username: 'Evgeny Petrashko',
                          value: _counter,
                          color: Colors.purple),
                      UserProgress(
                          username: 'Kamil Agliullin',
                          value: _counter,
                          color: Colors.green),
                      UserProgress(
                          username: 'Dmitrii Shabalin',
                          value: _counter,
                          color: Colors.blueAccent),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _setCounter(0.0),
                    child: const Text('0%'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () => _setCounter(0.25),
                    child: const Text('25%'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () => _setCounter(0.5),
                    child: const Text('50%'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () => _setCounter(0.75),
                    child: const Text('75%'),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () => _setCounter(1),
                    child: const Text('100%'),
                  ),
                ],
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
      ),
    );
  }
}
