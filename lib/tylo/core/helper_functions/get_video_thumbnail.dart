import 'package:tylo/tylo/core/resources/constants/app_strings.dart';

import '../utils/file_manager/ffmpeg_commands.dart';
import '../utils/file_manager/file_manager.dart';

Future<String?> getVideoThumbnail({required String videoPath}) async{
  final thumbnail = await FileManager.applyFfmpegCommand(
    filePath: videoPath,
    ffmpegCommand: videoThumbnailCommand,
    extension: AppStrings.jpg,
  );
  return thumbnail;
}