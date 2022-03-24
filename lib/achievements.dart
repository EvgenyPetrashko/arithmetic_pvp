import 'dart:async';
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, bottom: 30),
              child: const Text(
                'Achievements',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue[50],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[50],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue[100],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[100],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue[200],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[200],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue[300],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[300],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue[400],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.green[400],
                        child: const Center(
                          child: Text(
                            'Heed not the rabble',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
