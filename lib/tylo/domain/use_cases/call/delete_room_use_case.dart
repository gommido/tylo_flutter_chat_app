import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';

import '../../../core/error/failure.dart';

class DeleteRoomUseCase{
  DeleteRoomUseCase(this.callRepository);
  final CallRepository callRepository;

  Future<Either<Failure, void>> deleteRoom({
    required String id,
  })async{
    return await callRepository.deleteRoom(id: id);
  }
}