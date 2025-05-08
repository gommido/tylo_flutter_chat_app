
import '../../entities/app_user.dart';
import '../../repositories/firestore_repository/firestore_repository.dart';

class GetUserAsStreamUseCase{
  GetUserAsStreamUseCase(this.fireStoreRepository);
  final FireStoreRepository fireStoreRepository;

  Stream<AppUser?> getUserAsStream({required String id,}){
    return fireStoreRepository.getUserAsStream(id: id);
  }
}