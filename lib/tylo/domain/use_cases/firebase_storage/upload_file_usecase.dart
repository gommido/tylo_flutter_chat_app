import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../repositories/fire_storage_repository/firestorage_repository.dart';

class UploadFileToFireStorageUseCase{
  UploadFileToFireStorageUseCase(this.fireStorageRepository);
  final FireStorageRepository fireStorageRepository;

  Future<Either<Failure, String>> uploadFileToFireStorage({required String folder, required File file}) async{
    return await fireStorageRepository.uploadFileToFireStorage(folder: folder, file: file);
  }

}