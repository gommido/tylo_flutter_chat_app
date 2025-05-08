import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../services/shared_preference/shared_prefs_manager.dart';

String checkIfNumberContainsCountryCode(String number){
  String phoneNumber = '';
  final countryMap = SharedPrefsManager.getMapData(key: AppStrings.country);
  if(number.startsWith('+')){
    phoneNumber = '00$number';
  }else{
    if(!number.startsWith(countryMap['code'])){
      phoneNumber = '${countryMap['code']}$number';
    }
  }
  return phoneNumber;
}