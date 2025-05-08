import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';


abstract class FireStorageRepository{

  Future<Either<Failure, String>> uploadFileToFireStorage({required String folder, required File file});
  Future<Either<Failure, void>> deleteStoredFile({required String fileUrl,});

}