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
            title: const Text('Settings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Setting 1'),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Setting 2'),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Setting 3'),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Setting 4'),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "Set",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(onPressed: _dismissDialog, child: const Text('Close')),
              TextButton(
                onPressed: _dismissDialog,
                child: const Text('Apply'),
              )
            ],
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: OutlinedButton(
        onPressed: _showMaterialDialog,
        child: const Text(
          "Settings",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
