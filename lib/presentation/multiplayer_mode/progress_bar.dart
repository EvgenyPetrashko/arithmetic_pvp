import 'package:flutter/material.dart';

class UserProgress extends StatefulWidget {
  final String username;
  final double value;
  final Color color;

  const UserProgress(
      {Key? key,
      required this.username,
      required this.value,
      required this.color})
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
                child: Text(
                  widget.username,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 75,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: widget.value),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, _) => ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    value: value,
                    semanticsLabel: 'User progress',
                    color: widget.color,
                    backgroundColor: Colors.black12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
