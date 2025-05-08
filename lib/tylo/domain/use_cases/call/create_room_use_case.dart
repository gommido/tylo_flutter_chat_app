import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';

import '../../../core/error/failure.dart';

class CreateRoomUseCase{
  CreateRoomUseCase(this.callRepository);
  final CallRepository callRepository;

  Future<Either<Failure, void>> createRoom({
    required String id,
    required String callReceiverId,
    required String callerId,
    required String callerName,
    required String callerImage,
  })async{
    return await callRepository.createRoom(id: id, callReceiverId: callReceiverId, callerId: callerId, callerName: callerName, callerImage: callerImage);
  }
}