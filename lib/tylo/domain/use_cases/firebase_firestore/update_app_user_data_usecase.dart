import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../repositories/firestore_repository/firestore_repository.dart';

class UpdateAppUserDataUseCase{
  UpdateAppUserDataUseCase(this.fireStoreRepository);
  final FireStoreRepository fireStoreRepository;

  Future<Either<Failure, void>> updateAppUserData({
    required String id,
    required String field,
    dynamic value,
  })async{
    return await fireStoreRepository.updateAppUserData(id: id, field: field, value: value,);
  }
}