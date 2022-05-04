import 'package:flutter/material.dart';

class UserProgress extends StatefulWidget {
  final String username;
  final double value;

  const UserProgress({Key? key, required this.username, required this.value})
      : super(key: key);

  @override
  State<UserProgress> createState() => _UserProgressState();
}

class _UserProgressState extends State<UserProgress> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Expanded(
              flex: 25,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(widget.username, textAlign: TextAlign.center,),
              ),
            ),
            Expanded(
              flex: 75,
              child: LinearProgressIndicator(
                value: widget.value,
                semanticsLabel: 'User progress',
                color: Colors.black,
                backgroundColor: Colors.black12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
