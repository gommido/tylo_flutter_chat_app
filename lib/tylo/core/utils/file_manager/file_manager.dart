import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import '../../shared/temporary_directory_manager.dart';
import '../../shared/uuid_manager.dart';

class FileManager{


  static Future<String?> applyFfmpegCommand({
    required String filePath,
    required String ffmpegCommand,
    required String extension,

  })async {
    final directory = await TemporaryDirectoryManager.getTemporaryDirectoryPath();
    final outputPath = '$directory/${getUuid()}.$extension';
    final command = '-i $filePath $ffmpegCommand $outputPath';
    final session = await FFmpegKit.execute(command);
    final returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return outputPath;
    }
    return null;
  }

}