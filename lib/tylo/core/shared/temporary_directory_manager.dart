import 'dart:io';

import 'package:path_provider/path_provider.dart';

class TemporaryDirectoryManager{

  static Future<String> getTemporaryDirectoryPath()async{
    final directory = await getTemporaryDirectory();
    return directory.path;
  }


  static Future<void> cleanTemporaryDirectory() async {
    final directory = await getTemporaryDirectory();
    final dir = Directory(directory.path);
    try {
      if (dir.existsSync()) {
        dir.listSync().forEach((file) {
          file.deleteSync();
        });
      }
    } catch (e) {
      print("Error while cleaning temporary directory: $e");
    }
  }
}