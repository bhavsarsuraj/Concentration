import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static SharedPreferences _prefs;

  static void initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int getIntFor({@required String key}) {
    return _prefs.getInt(key);
  }

  // static void setIntFor({@required String key, @required int value}) {
  //   return _prefs.set
  // }

  static bool getBoolFor({@required String key}) {
    return _prefs.getBool(key);
  }

  static String getStringFor({@required String key}) {
    return _prefs.getString(key);
  }

  static double getDoubleFor({@required String key}) {
    return _prefs.getDouble(key);
  }
}
