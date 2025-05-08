import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalStorage{
  static late FlutterSecureStorage _flutterSecureStorage;

  static void initFlutterSecureStorage(){
    _flutterSecureStorage = const FlutterSecureStorage();
  }

  static Future<void> write({required String key, required String value,}) async{
    await _flutterSecureStorage.write(key: key, value: value);
  }
  static Future<String?> read({required String key,}) async{
    return await _flutterSecureStorage.read(key: key);
  }

}