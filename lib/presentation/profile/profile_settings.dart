import 'package:arithmetic_pvp/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            title: Text(AppLocalizations.of(context)?.settings??'Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      AppLocalizations.of(context)?.switch_mode??'Switch Mode',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const ThemeToggle(),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
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
