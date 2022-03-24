import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  final void Function(String) onTap;

  const Keyboard({Key? key, required this.onTap}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: const [
        KeyboardButton(val: '7'),
        KeyboardButton(val: '8'),
        KeyboardButton(val: '9'),
      ]),
      Row(children: const [
        KeyboardButton(val: '4'),
        KeyboardButton(val: '5'),
        KeyboardButton(val: '6'),
      ]),
      Row(children: const [
        KeyboardButton(val: '1'),
        KeyboardButton(val: '2'),
        KeyboardButton(val: '3'),
      ]),
      Row(children: const [
        KeyboardButton(val: '-'),
        KeyboardButton(val: '0'),
        KeyboardButton(val: 'DEL'),
      ]),
    ]);
  }
}

class KeyboardButton extends StatelessWidget {
  final String val;

  const KeyboardButton({Key? key, required this.val}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1),
        child: ElevatedButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            primary: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {

          },
          child: Text(
            val,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
