import 'package:arithmetic_pvp/presentation/game/game_appbar.dart';
import 'package:arithmetic_pvp/presentation/profile/profile.dart';
import 'package:arithmetic_pvp/presentation/profile/profile_appbar.dart';
import 'package:arithmetic_pvp/presentation/skins/skins.dart';
import 'package:flutter/material.dart';
import 'game/utils/game.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List _children = [
    const GamePage(),
    const ShopPage(),
    const ProfilePage()
  ];

  final List _appBars = [
    const GameAppBar(),
    const ProfileAppBar(),
    const ProfileAppBar()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[_selectedIndex],
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
