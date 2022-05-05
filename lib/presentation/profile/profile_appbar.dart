import 'package:arithmetic_pvp/presentation/profile/profile_settings.dart';
import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text('My Profile'), actions: const [ProfileSettings()]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
