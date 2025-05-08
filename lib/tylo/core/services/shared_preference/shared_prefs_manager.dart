import 'dart:convert';

import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_initi.dart';

class SharedPrefsManager{


  static Future<bool> saveStringData({required String key, required String value}) async{
    return await SharedPrefsInit.prefs.setString(key, value);
  }

  static String? getStringData({required String key}){
    return SharedPrefsInit.prefs.getString(key);
  }

  static Future<bool> saveBoolData({required String key, required bool value}) async{
    return await SharedPrefsInit.prefs.setBool(key, value);
  }

  static bool? getBoolData({required String key,}) {
    return  SharedPrefsInit.prefs.getBool(key,);
  }

  static Future<bool> saveIntegerData({required String key, required int value}) async{
    return await SharedPrefsInit.prefs.setInt(key, value);
  }

  static int? getIntegerData({required String key,}) {
    return SharedPrefsInit.prefs.getInt(key,) ?? 0;
  }

  static Future<bool> saveListData({required String key, required List<Map<String, dynamic>> mapList}) async{
    List<String> list = [];
    for(final map in mapList){
      list.add(json.encode(map));
    }
    return await SharedPrefsInit.prefs.setStringList(key, list);
  }

  static List<String> getListData({required String key}) {
    return SharedPrefsInit.prefs.getStringList(key) ?? [];
  }


  static Future<bool> saveMapData({required String key, required Map<String, dynamic> map}) async{
    String value = jsonEncode(map);
    return await SharedPrefsInit.prefs.setString(key, value);
  }

  static Map<String, dynamic> getMapData({required String key,}) {
    String? jsonString = SharedPrefsInit.prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return {};

  }




}