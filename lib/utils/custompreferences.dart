import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CustomPreferences {
  //Save particular key value to sp
  static setPreferences(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
  }

  //get particular key value to sp
  static getPreferences(String key) async {
    var prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString(key).toString();
    return stringValue;
  }


  //Clear all the keys data from sp
  static Future<bool> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }





}
