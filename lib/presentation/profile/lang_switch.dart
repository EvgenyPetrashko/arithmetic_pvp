import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LangToggle extends StatefulWidget {
  const LangToggle({Key? key}) : super(key: key);

  @override
  State<LangToggle> createState() => _LangToggleState();
}

class _LangToggleState extends State<LangToggle> {
  // final darkIcon = const Icon(
  //   Icons.dark_mode,
  //   color: Color(0xffffe78a),
  //   size: 34,
  // );
  // final lightIcon = const Icon(
  //   Icons.light_mode,
  //   color: Color(0xffffc414),
  //   size: 34,
  // );

  // var _icon;
  var _isEnglish;

  @override
  void initState() {
    super.initState();
    // _icon = lightIcon;
    // _isDarkTheme = false;
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
      labels: const ['RU', 'EN'],
      iconSize: 30.0,
      activeBgColors: const [
        [Color(0xff7a8fff), Color(0xff3b59ec)],
        [Colors.greenAccent, Colors.green]
      ],
      animate: true,
      onToggle: (index) {
        print('switched to: $index');
        if (index == 0) {
          _isEnglish = false;
        } else {
          _isEnglish = true;
        }
        print(_isEnglish);
      },
    );
  }
}
