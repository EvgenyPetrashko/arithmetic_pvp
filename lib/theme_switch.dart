import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({Key? key}) : super(key: key);

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  final darkIcon = const Icon(
    Icons.dark_mode,
    color: Color(0xffffe78a),
    size: 34,
  );
  final lightIcon = const Icon(
    Icons.light_mode,
    color: Color(0xffffc414),
    size: 34,
  );

  var _icon;
  var _isDarkTheme;

  @override
  void initState() {
    super.initState();
    _icon = lightIcon;
    _isDarkTheme = false;
  }

  // void _switchTheme() {
  //   setState(
  //         () {
  //       if (_icon == lightIcon) {
  //         _icon = darkIcon;
  //       } else {
  //         _icon = lightIcon;
  //       }
  //       _isDarkTheme = !_isDarkTheme;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //     child: CircleAvatar(
    //         child: IconButton(icon: _icon, onPressed: _switchTheme)),
    // );
    return ToggleSwitch(
      minWidth: 42,
      minHeight: 35,
      initialLabelIndex: 1,
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
        print('switched to: $index');
        if (index == 0) {
          _isDarkTheme = true;
        }
        else{
          _isDarkTheme = false;
        }
        print(_isDarkTheme);
      },
    );
  }
}
