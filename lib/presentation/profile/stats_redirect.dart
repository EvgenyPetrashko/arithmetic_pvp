import 'package:arithmetic_pvp/presentation/stats/stats_overall.dart';
import 'package:flutter/material.dart';

class RedirectToStats extends StatelessWidget {
  const RedirectToStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OverallStatsPage(),
            ),
          );
        },
        child: const Text(
          "Game stats",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 20),
    );
  }
}
