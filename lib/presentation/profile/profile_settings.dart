import 'package:arithmetic_pvp/presentation/profile/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'lang_switch.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _dismissDialog() {
      Navigator.pop(context);
    }

    _showMaterialDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color(0xff393939),
            title: Text(AppLocalizations.of(context)?.settings??'Settings', textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.switch_mode??'Switch Mode',
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const ThemeToggle(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Language',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    LangToggle(),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black, elevation: 3),
                  onPressed: _dismissDialog,
                  child: Text(AppLocalizations.of(context)?.done??"Done"),
                ),
              ),
            ],
          );
        },
      );
    }

    return IconButton(
      onPressed: _showMaterialDialog,
      icon: const Icon(Icons.settings),
    );
  }
}
