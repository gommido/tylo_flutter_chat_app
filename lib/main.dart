import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tylo/tylo/app/my_app.dart';
import 'package:tylo/tylo/app_routing.dart';
import 'package:tylo/tylo/core/resources/constants/app_languages.dart';
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';
import 'package:tylo/tylo/core/resources/constants/country_codes.dart';
import 'package:tylo/tylo/core/services/injector.dart';
import 'package:tylo/tylo/core/services/secure_local_storage/secure_local_storage.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_initi.dart';
import 'package:tylo/tylo/core/services/shared_preference/shared_prefs_manager.dart';
import 'dart:io' show Platform;

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  String localeName = Platform.localeName;
  final code = localeName.split('_').last;
  final language = localeName.split('_').first;
  final countryMap = countryCodes.where((country) => country[AppStrings.name] == code).first;
  initGetIt();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  await SharedPrefsInit.initSharedPref();
  await SharedPrefsManager.saveMapData(key: AppStrings.country, map: countryMap);
  SharedPrefsManager.getMapData(key: AppStrings.country);
  SecureLocalStorage.initFlutterSecureStorage();

  final langMap = languages.firstWhere((lang)=> lang[AppStrings.tag] == language, orElse: ()=> {});
  if(langMap.isEmpty){
    await SharedPrefsManager.saveStringData(key: AppStrings.language, value: AppStrings.en);
  }else{
    if(SharedPrefsManager.getStringData(key: AppStrings.language) == null){
      await SharedPrefsManager.saveStringData(key: AppStrings.language, value: language);
    }else{
      if(SharedPrefsManager.getStringData(key: AppStrings.language) == language){
        await SharedPrefsManager.saveStringData(key: AppStrings.language, value: language);
      }else{
        final lang = SharedPrefsManager.getStringData(key: AppStrings.language);
        await SharedPrefsManager.saveStringData(key: AppStrings.language, value: lang!);
      }
    }
  }
  runApp(MyApp(appRouting: AppRouting(),));
}

