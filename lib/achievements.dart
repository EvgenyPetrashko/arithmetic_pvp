import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}


class _AchievementsPageState extends State<AchievementsPage> {
  late Future futureAlbum;



  var entries = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          isAlwaysShown: true,
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  entries[index],
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'selected category \"${entries[index]}\"',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(thickness: 1),
          ),
        ),
      ),
    );
  }
}
