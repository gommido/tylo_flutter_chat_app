import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsInit{
   static late SharedPreferences prefs;

   static Future initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }
}