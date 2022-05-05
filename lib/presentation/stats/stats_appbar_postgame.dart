import 'package:flutter/material.dart';

class StatsAppBarPostgame extends StatelessWidget implements PreferredSizeWidget {
  const StatsAppBarPostgame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Post-game Statistics'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
