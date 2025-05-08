import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../repositories/auth_repository/firebase_auth_repository.dart';

class GetCurrentUserIdUseCase{
  GetCurrentUserIdUseCase(this.fireBaseAuthRepository);
  final FireBaseAuthRepository fireBaseAuthRepository;

  Either<Failure, String> getCurrentUserId() {
    return fireBaseAuthRepository.getCurrentUserId();
  }

}