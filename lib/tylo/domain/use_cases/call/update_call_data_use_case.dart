import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';

import '../../../core/error/failure.dart';

class UpdateCallDataUseCase{
  UpdateCallDataUseCase(this.callRepository);
  final CallRepository callRepository;

  Future<Either<Failure, void>> updateCallData({
    required String id,
    required String callId,
    required String field,
    dynamic value,
  })async{
    return await callRepository.updateCallData(id: id, callId: callId, field: field, value: value,);
  }
}