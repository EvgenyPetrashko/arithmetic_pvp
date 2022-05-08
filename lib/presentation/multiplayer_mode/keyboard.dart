import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final void Function(String) onTap;

  const Keyboard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          KeyboardButton(val: '7', onTap: onTap),
          KeyboardButton(val: '8', onTap: onTap),
          KeyboardButton(val: '9', onTap: onTap),
        ]),
      ),
      Expanded(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          KeyboardButton(val: '4', onTap: onTap),
          KeyboardButton(val: '5', onTap: onTap),
          KeyboardButton(val: '6', onTap: onTap),
        ]),
      ),
      Expanded(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          KeyboardButton(val: '1', onTap: onTap),
          KeyboardButton(val: '2', onTap: onTap),
          KeyboardButton(val: '3', onTap: onTap),
        ]),
      ),
      Expanded(
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // KeyboardButton(val: '-', onTap: widget.onTap),
          KeyboardButton(val: '0', onTap: onTap),
          KeyboardButton(val: 'DEL', onTap: onTap),
        ]),
      ),
    ]);
  }
}

class KeyboardButton extends StatelessWidget {
  final String val;
  final void Function(String) onTap;

  const KeyboardButton({Key? key, required this.val, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // padding: const EdgeInsets.all(16.0),
            textStyle: const TextStyle(fontSize: 24),
          ),
          onPressed: () {
            onTap(val);
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
