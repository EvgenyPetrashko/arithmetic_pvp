import 'package:arithmetic_pvp/bloc/profile_bloc.dart';
import 'package:arithmetic_pvp/presentation/multiplayer_mode/game_appbar.dart';
import 'package:arithmetic_pvp/presentation/profile/profile.dart';
import 'package:arithmetic_pvp/presentation/profile/profile_appbar.dart';
import 'package:arithmetic_pvp/presentation/skins/skins.dart';
import 'package:arithmetic_pvp/presentation/skins/skins_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'multiplayer_mode/rating_game_start.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  final _profileBloc = ProfileBloc();

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _profileBloc,
      child: Scaffold(
        appBar: _appBars[_selectedIndex],
        body: SafeArea(
          child: _children[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.gamepad),
              label: AppLocalizations.of(context)?.game_page ?? 'Game',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.sentiment_very_satisfied),
              label: AppLocalizations.of(context)?.skins_title ?? 'Skins',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle),
              label:
                  AppLocalizations.of(context)?.my_profile_title ?? 'Profile',
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
