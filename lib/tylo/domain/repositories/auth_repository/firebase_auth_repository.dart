
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

abstract class FireBaseAuthRepository{

  Future<Either<Failure, void>> signUpWithPhoneNumber({required String phoneNumber});

  Future<Either<Failure, void>> verifyPhoneNumber({required String smsCode});

  Either<Failure, String> getCurrentUserId();

}