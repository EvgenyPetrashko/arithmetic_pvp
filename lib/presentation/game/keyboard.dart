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
      Row(children: [
        KeyboardButton(val: '7', onTap: widget.onTap),
        KeyboardButton(val: '8', onTap: widget.onTap),
        KeyboardButton(val: '9', onTap: widget.onTap),
      ]),
      Row(children: [
        KeyboardButton(val: '4', onTap: widget.onTap),
        KeyboardButton(val: '5', onTap: widget.onTap),
        KeyboardButton(val: '6', onTap: widget.onTap),
      ]),
      Row(children: [
        KeyboardButton(val: '1', onTap: widget.onTap),
        KeyboardButton(val: '2', onTap: widget.onTap),
        KeyboardButton(val: '3', onTap: widget.onTap),
      ]),
      Row(children: [
        KeyboardButton(val: '-', onTap: widget.onTap),
        KeyboardButton(val: '0', onTap: widget.onTap),
        KeyboardButton(val: 'DEL', onTap: widget.onTap),
      ]),
    ]);
  }
}


class KeyboardButton extends StatefulWidget {
  final String val;
  final void Function(String) onTap;

  const KeyboardButton({Key? key, required this.val, required this.onTap}) : super(key: key);

  @override
  _KeyboardButtonState createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> {

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
            widget.onTap(widget.val);
          },
          child: Text(
            widget.val,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
