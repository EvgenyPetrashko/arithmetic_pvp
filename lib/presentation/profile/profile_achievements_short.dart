import 'package:flutter/material.dart';

import 'achievements.dart';

class ProfileAchievements extends StatelessWidget {
  const ProfileAchievements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, bottom: 30),
          child: const Text(
            'Achievements',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80, minWidth: 50),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  children: const [
                    Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.red,
                    ),
                    Icon(
                      Icons.audiotrack,
                      size: 40,
                      color: Colors.blue,
                    ),
                    Icon(
                      Icons.beach_access,
                      size: 40,
                      color: Colors.pink,
                    ),
                    Icon(
                      Icons.savings,
                      size: 40,
                      color: Colors.amberAccent,
                    ),
                    Icon(
                      Icons.explore,
                      size: 40,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AchievementsPage(),
              ),
            );
          },
          child: const Text(
            "See more",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
