
import 'dart:io' as io;
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import '../error/exceptions.dart';
import '../error/failure.dart';

class PickFiles{

  late FilePicker filePicker;

  Future<Either<Failure, io.File>?> pickFile({required FileType type})async{
   try{
     final result = await FilePicker.platform.pickFiles(
       type: type,
     );
     if(result == null) return null;
     final imageFile = io.File(result.files.single.path!);
     return Right(imageFile);
   } on LocalExceptions catch(error){
     throw LocalExceptions(errorMessage: error.errorMessage);
   }
  }

  Future<Either<Failure, io.File>?> pickAudio()async{
    try{
      final result = await FilePicker.platform.pickFiles(type: FileType.any,);
      if(result == null) return null;
      final audioPath = io.File(result.files.single.path!);
      return Right(audioPath);
    } on LocalExceptions catch(error){
      throw LocalExceptions(errorMessage: error.errorMessage);
    }
  }



}
