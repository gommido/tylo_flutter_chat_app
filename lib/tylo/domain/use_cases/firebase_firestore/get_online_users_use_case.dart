
import '../../entities/app_user.dart';
import '../../repositories/firestore_repository/firestore_repository.dart';

class GetOnlineUsersUseCase{
  GetOnlineUsersUseCase(this.fireStoreRepository);
  final FireStoreRepository fireStoreRepository;

  Stream<List<AppUser>> getOnlineUsers({required List<String> ids}){
    return fireStoreRepository.getOnlineUsers(ids: ids);
  }
}