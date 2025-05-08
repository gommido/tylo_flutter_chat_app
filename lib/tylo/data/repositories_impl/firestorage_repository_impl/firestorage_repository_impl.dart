import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/core/error/failure.dart';
import 'package:tylo/tylo/data/data_sources/remote/firebase_storage/fire_storage_data_source.dart';
import 'package:tylo/tylo/domain/repositories/fire_storage_repository/firestorage_repository.dart';

import '../../../core/error/exceptions.dart';

class FireStorageRepositoryImpl implements FireStorageRepository{
  FireStorageRepositoryImpl(this.fireStorageDataSource);
  final FireStorageDataSource fireStorageDataSource;

  @override
  Future<Either<Failure, String>> uploadFileToFireStorage({
    required String folder,
    required File file,
  })async {
    try{
      final result =  await fireStorageDataSource.uploadFileToFireStorage(folder: folder, file: file);
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStoredFile({required String fileUrl}) async{
    try{
      final result =  await fireStorageDataSource.deleteStoredFile(fileUrl: fileUrl);
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }
}