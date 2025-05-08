import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../error/exceptions.dart';

class FilePickerManager{


  Future<(File, String)?> pickFile({
    required ImageSource source,
    required String type,

  })async{
    try{
      XFile? pickedFile;
      FilePickerResult? result;
      final ImagePicker picker = ImagePicker();
      if(type == 'image'){
        pickedFile = await picker.pickImage(source: source);
      }else if(type == 'video'){
        pickedFile = await picker.pickVideo(source: source);
      }else{
        result = await FilePicker.platform.pickFiles();
      }
      File? file;
      if(type == 'audio'){
        if(result == null) return null;
        file = File(result.files.single.path!);
      }else{
        if(pickedFile == null) return null;
        file = File(pickedFile.path);
      }
      final extension = file.path.split('.').last;
      final fileType = getFileType(extension: extension);
      return (file, fileType);
    } on LocalExceptions catch(error){
      throw LocalExceptions(errorMessage: error.errorMessage);
    }
  }
  String getFileType({required String extension}){
    if(types['image'].contains(extension)){
      return 'image';
    }else if(types['video'].contains(extension)){
      return 'video';
    }else if(types['audio'].contains(extension)){
      return 'audio';
    }else if(types['pdf'].contains(extension)){
      return 'pdf';
    }else{
      return 'unknown';
    }
  }


  Map<String, dynamic> types = {
    'image': [
      'png', 'jpg', 'jpeg', 'gif', 'bmp', 'tiff', 'webp',
    ],
    'video': [
      'mp4', 'mov', 'avi', 'mkv', 'wmv', 'flv', 'webm', '3gp', 'mpeg ', 'm4v', 'mts ', 'vob',
    ],
    'audio': [
      'mp3',
      'wav',
      'aac',
      'flac',
      'ogg',
      'wma',
      'alac',
      'aiff',
      'pcm',
      'm4a',
      'opus',
      'amr',
      'dsd',
      'mid',
      'aiff',
    ],
    'pdf': ['pdf', ],
  };


}