import 'package:flutter/material.dart';

class StatsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Your Postgame Statistics'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
