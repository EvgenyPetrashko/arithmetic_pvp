

import 'package:shared_preferences/shared_preferences.dart';

class Storage{
  late SharedPreferences _pref;

  init() async {
    _pref = await SharedPreferences.getInstance();
  }

  getValue(key, defaultValue) async{
    return _pref.get(key) ?? defaultValue;
  }

  setBool(key, value) async{
    _pref.setBool(key, value);
  }

  setString(key, value) async{
    _pref.setString(key, value);
  }

  bool containKey(key){
    return _pref.containsKey(key);
  }
}