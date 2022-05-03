
import 'package:arithmetic_pvp/bloc/balance_bloc.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/game_appbar.dart';
import 'package:arithmetic_pvp/presentation/profile/profile.dart';
import 'package:arithmetic_pvp/presentation/profile/profile_appbar.dart';
import 'package:arithmetic_pvp/presentation/skins/skins.dart';
import 'package:arithmetic_pvp/presentation/skins/skins_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'multiplayer_mode/multiplayer_game_start.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int balance = 0;
  final List _children = [
    const MultiplayerGameStartPage(),
    const SkinsPage(),
    const ProfilePage()
  ];

  final List _appBars = [
    const GameAppBar(),
    const SkinsAppBar(),
    const ProfileAppBar()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 2;
  }


  @override
  Widget build(BuildContext context) {
    final _balanceBloc = BalanceBloc();
    return BlocProvider(
      create: (context) => _balanceBloc,
      child: Scaffold(
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
      ),
    );
  }
}
