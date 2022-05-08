import 'package:arithmetic_pvp/presentation/stats/stats_overall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RedirectToStats extends StatelessWidget {
  const RedirectToStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OverallStatsPage(),
            ),
          );
        },
        child: Text(
          AppLocalizations.of(context)?.see_all??"See all", style: const TextStyle(fontSize: 16),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 20),
    );
  }
}
