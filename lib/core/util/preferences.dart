import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ffi';
import 'dart:async';

Future<dynamic> getPreference(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  dynamic value = preferences.get(key);
  return value;
}

Future<bool> setPreference(String key, dynamic value) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print('$value stored successfully');
  bool status;

  if(value.runtimeType == bool) {
    status = await preferences.setBool(key, value);
  } else if(value.runtimeType == int) {
    status = await preferences.setInt(key, value);
  } else if(value.runtimeType == double) {
    status = await preferences.setDouble(key, value);
  } else if(value.runtimeType == String) {
    status = await preferences.setString(key, value);
  }
  return status;
}

Future<bool> removePreference(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool status = await preferences.remove(key);

  return status;
}

Future<bool> clearPreferences() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool status = await preferences.clear();

  return status;
}