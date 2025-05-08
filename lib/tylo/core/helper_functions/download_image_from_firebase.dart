import 'dart:io';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../utils/permission_manager.dart';

PermissionManager permissionManager = PermissionManager();


Future<void> downloadAndSaveImage({required String imageUrl, required String fileName,}) async {
  final permissionStatus = await permissionManager.getPermission(Permission.storage);
  if(permissionStatus == PermissionStatus.granted){
    Directory? appDir = await getExternalStorageDirectory();
    String directoryPath = path.join(appDir!.path, AppStrings.images,);
    Directory directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    String filePath = path.join(directoryPath, '$fileName.${AppStrings.png}');
    try {
      Dio dio = Dio();
      await dio.download(imageUrl, filePath);

    } catch (e) {
      print('Error downloading or saving the image: $e');
    }
  }

}
