import 'package:tylo/tylo/domain/entities/room.dart';
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';


class GetCallRoomUseCase{
  GetCallRoomUseCase(this.callRepository);
  final CallRepository callRepository;

  Stream<Room?> getCallRoom({
    required String userId,
    required String field,
  }){
    return callRepository.getCallRoom(userId: userId, field: field,);
  }
}