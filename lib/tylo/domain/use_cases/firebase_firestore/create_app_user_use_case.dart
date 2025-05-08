import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../repositories/firestore_repository/firestore_repository.dart';

class CreateAppUserUseCase{
  CreateAppUserUseCase(this.fireStoreRepository);
  final FireStoreRepository fireStoreRepository;

  Future<Either<Failure, void>> createAppUser({
    required String id,
    required String name,
    required String phone,
    required String photo,
    required String token,
  })async {
    return await fireStoreRepository.createAppUser(
      id: id,
      name: name,
      phone: phone,
      photo: photo,
      token: token,
    );
  }


}