import 'dart:async';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  var i = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   i = 0;
  // }

  void _increment() {
    setState(() {
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: const Text("Game page",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            margin: const EdgeInsets.only(top: 30, bottom: 40),
          ),
          Container(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Text(
              i.toString(),
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              height: 50,
              child: ElevatedButton(
                onPressed: _increment,
                child: const Text('MORE'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
