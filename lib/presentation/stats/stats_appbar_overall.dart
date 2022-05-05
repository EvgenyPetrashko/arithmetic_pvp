import 'package:flutter/material.dart';

class StatsAppBarOverall extends StatelessWidget implements PreferredSizeWidget {
  const StatsAppBarOverall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Overall Statistics'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
