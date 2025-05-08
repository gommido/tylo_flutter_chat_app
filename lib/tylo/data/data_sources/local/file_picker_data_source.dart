import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../../../core/error/exceptions.dart';

class FilePickerDataSource{
  late FilePicker filePicker;
  Future<File?> pickFile({required FileType type})async{
    try{
      final result = await FilePicker.platform.pickFiles(
        type: type,
      );
      if(result == null) return null;
      final imageFile = File(result.files.single.path!);
      return imageFile;
    } on LocalExceptions catch(error){
      throw LocalExceptions(errorMessage: error.errorMessage);
    }
  }
}