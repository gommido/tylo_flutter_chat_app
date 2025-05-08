import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../repositories/fire_storage_repository/firestorage_repository.dart';

class DeleteStoredFileUseCase{
  DeleteStoredFileUseCase(this.fireStorageRepository);
  final FireStorageRepository fireStorageRepository;

  Future<Either<Failure, void>> deleteStoredFile({required String fileUrl,}) async{
    return await fireStorageRepository.deleteStoredFile(fileUrl: fileUrl, );
  }

}