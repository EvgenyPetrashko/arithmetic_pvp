import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _dismissEditDialog() {
      Navigator.pop(context);
    }

    _showEditDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Change username'),
            content: Row(
              children: [
                const Expanded(
                  child: TextField(
                    maxLength: 30,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type desired username',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                OutlinedButton(onPressed: () {}, child: const Text("Check"))
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: _dismissEditDialog,
                child: const Text('Cancel'),
              ),
              const TextButton(
                onPressed: null,
                child: Text('Apply'),
              )
            ],
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: ElevatedButton(
        onPressed: _showEditDialog,
        child: const Text(
          "Edit profile",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
