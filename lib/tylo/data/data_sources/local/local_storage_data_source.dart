import 'dart:convert';

import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';

class LocalStorageDataSource{

  Future<bool> saveContactsToLocalStorage({required String key, required List<Map<String, dynamic>> mapList}) async{
    try{
      return await SharedPrefsManager.saveListData(key: key, mapList: mapList);
    }catch(e){
      return false;
    }
  }

  List<dynamic> getContactsFromLocalStorage({required String key})  {
    try{
      List encodedMapList =  SharedPrefsManager.getListData(key: key);
      final data = encodedMapList.map((e) => jsonDecode(e)).toList();
      return data;
    } catch(e){
      return [];
    }
  }

}