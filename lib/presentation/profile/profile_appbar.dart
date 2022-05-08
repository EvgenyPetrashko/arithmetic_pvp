import 'package:arithmetic_pvp/presentation/profile/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(AppLocalizations.of(context)?.my_profile_title??'My Profile'), actions: const [ProfileSettings()]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
