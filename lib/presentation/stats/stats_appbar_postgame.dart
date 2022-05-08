import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatsAppBarPostgame extends StatelessWidget
    implements PreferredSizeWidget {
  const StatsAppBarPostgame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)?.post_game_stats_title ??
          'Post-game Statistics'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
