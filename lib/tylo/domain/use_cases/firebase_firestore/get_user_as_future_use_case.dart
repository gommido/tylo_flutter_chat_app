import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../entities/app_user.dart';
import '../../repositories/firestore_repository/firestore_repository.dart';

class GetUserAsFutureUseCase{
  GetUserAsFutureUseCase(this.fireStoreRepository);
  final FireStoreRepository fireStoreRepository;

  Future<Either<Failure, AppUser?>> getUserAsFuture({required String id,})async{
    return await fireStoreRepository.getUserAsFuture(id: id);
  }
}