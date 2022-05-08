import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../bloc/events/profile_events.dart';
import '../../bloc/profile_bloc.dart';
import '../../main.dart';

class ThemeToggle extends StatelessWidget {
  final _profileBloc = ProfileBloc();

  ThemeToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 42,
      minHeight: 35,
      initialLabelIndex: MyApp.themeNotifier.value == ThemeMode.dark ? 0 : 1,
      cornerRadius: 10.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      totalSwitches: 2,
      icons: const [
        Icons.dark_mode,
        Icons.light_mode,
      ],
      iconSize: 30.0,
      activeBgColors: const [
        [Color(0xff1C1C78), Color(0xff0e122b)],
        [Colors.yellow, Colors.orange]
      ],
      animate: true,
      onToggle: (index) {
        bool isDark = true;
        if (index == 1) {
          isDark = false;
        }
        _profileBloc.add(ProfileEventChangeThemeMode(isDark));
      },
    );
  }
}
