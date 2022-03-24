

import 'package:shared_preferences/shared_preferences.dart';

class Storage{
  late Future<SharedPreferences> _futurePref;

  Storage(){
    _futurePref = init();
  }

  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  setBool(key, value) async{
    var _pref = await _futurePref;
    _pref.setBool(key, value);
  }

  setString(key, value) async{
    var _pref = await _futurePref;
    _pref.setString(key, value);
  }

  Future<bool> containKey(key) async{
    var _pref = await _futurePref;
    return _pref.containsKey(key);
  }
}