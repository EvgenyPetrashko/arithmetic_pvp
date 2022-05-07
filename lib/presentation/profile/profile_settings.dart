import 'package:arithmetic_pvp/theme_switch.dart';
import 'package:flutter/material.dart';

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
            title: const Text('Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      'Switch Mode',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    ThemeToggle(),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: ElevatedButton(
                  onPressed: _dismissDialog,
                  child: const Text('Done'),
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
