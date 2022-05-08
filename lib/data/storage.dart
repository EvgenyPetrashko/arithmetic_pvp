import 'dart:convert';

import 'package:arithmetic_pvp/data/models/cookie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/profile.dart';

class Storage {
  static SharedPreferences? _futurePref;

  Future<Storage> init() async {
    _futurePref ??= await SharedPreferences.getInstance();
    return this;
  }

  setBool(key, value) {
    _futurePref?.setBool(key, value);
  }

  bool getBool(key, bool value) {
    return _futurePref?.getBool(key) ?? value;
  }

  setProfile(key, Profile value) {
    _futurePref?.setString(key, jsonEncode(value.toJson()));
  }

  Profile? getProfile(key) {
    String? value = _futurePref?.getString(key);
    if (value == null) {
      return null;
    } else {
      return Profile.fromJson(jsonDecode(value));
    }
  }

  setCookie(key, Cookie value) {
    _futurePref?.setString(key, jsonEncode(value.toJson()));
  }

  Cookie? getCookie(key) {
    String? value = _futurePref?.getString(key);
    if (value == null) {
      return null;
    } else {
      return Cookie.fromJson(jsonDecode(value));
    }
  }

  setString(key, value) {
    _futurePref?.setString(key, value);
  }

  String getString(key, defaultValue) {
    return _futurePref?.getString(key) ?? defaultValue;
  }

  bool containKey(key) {
    return _futurePref?.containsKey(key) ?? false;
  }
}
