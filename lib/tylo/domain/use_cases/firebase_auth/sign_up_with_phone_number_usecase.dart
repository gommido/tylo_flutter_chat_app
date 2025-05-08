
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/auth_repository/firebase_auth_repository.dart';


class SignUpWithPhoneNumberUseCase{
  SignUpWithPhoneNumberUseCase(this.fireBaseAuthRepository);
  final FireBaseAuthRepository fireBaseAuthRepository;

  Future<Either<Failure, void>> signUpWithPhoneNumber({required String phoneNumber})async {
    return await fireBaseAuthRepository.signUpWithPhoneNumber(phoneNumber: phoneNumber);
  }

  Future<Either<Failure, void>> verifyPhoneNumber({required String smsCode})async {
    return await fireBaseAuthRepository.verifyPhoneNumber(smsCode: smsCode);
  }

}