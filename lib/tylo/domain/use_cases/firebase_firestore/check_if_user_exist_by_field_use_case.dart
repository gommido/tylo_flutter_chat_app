

import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/app_user.dart';
import '../../repositories/firestore_repository/firestore_repository.dart';

class CheckIfUserExistByFieldUseCase{
  CheckIfUserExistByFieldUseCase(this.fireStoreRepository);
  final FireStoreRepository fireStoreRepository;

  Future<Either<Failure, AppUser?>> checkIfUserExistByField({required String field, required dynamic value,})async{
    return await fireStoreRepository.checkIfUserExistByField(field: field, value: value);
  }
}