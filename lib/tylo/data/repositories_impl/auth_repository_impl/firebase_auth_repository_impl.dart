import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/auth_repository/firebase_auth_repository.dart';
import '../../data_sources/remote/auth/firebase_auth_data_source.dart';

class FireBaseAuthRepositoryImpl implements FireBaseAuthRepository{
  FireBaseAuthRepositoryImpl(this._fireBaseAuthDataSource);
  final FireBaseAuthDataSource _fireBaseAuthDataSource;

  @override
  Future<Either<Failure, void>> signUpWithPhoneNumber({required String phoneNumber})async {
    try{
      final result = await _fireBaseAuthDataSource.signUpWithPhoneNumber(phoneNumber: phoneNumber);
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhoneNumber({required String smsCode}) async{
    try{
      final result =  await _fireBaseAuthDataSource.verifyNumber(smsCode: smsCode);
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Either<Failure, String> getCurrentUserId() {
    try{
      final result = _fireBaseAuthDataSource.getCurrentUserId();
      return Right(result ?? '');
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  /*
  @override
  Future<Either<Failure, User?>> signInWithGoogleAccount()async {
    try{
      final result = await _fireBaseAuthDataSource.signInWithGoogleAccount();
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, User?>> signInWithFacebookAccount()async {
    try{
      final result = await _fireBaseAuthDataSource.signInWithFacebookAccount();
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

   */
  
}