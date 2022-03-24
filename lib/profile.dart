import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var i = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   i = 0;
  // }

  void _increment() {
    setState(() {
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: const Text(
              "My Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:
                        Image.asset('assets/logo.png', width: 150, height: 150),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:
                        Image.asset('assets/logo.png', width: 150, height: 150),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              height: 50,
              child: ElevatedButton(
                onPressed: _increment,
                child: const Text('MORE'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
