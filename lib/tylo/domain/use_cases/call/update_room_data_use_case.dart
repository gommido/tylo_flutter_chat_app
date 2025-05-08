import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';

import '../../../core/error/failure.dart';

class UpdateRoomDataUseCase{
  UpdateRoomDataUseCase(this.callRepository);
  final CallRepository callRepository;

  Future<Either<Failure, void>> updateRoomData({
    required String roomId,
    required String field,
    dynamic value,
  })async{
    return await callRepository.updateRoomData(roomId: roomId, field: field, value: value,);
  }
}