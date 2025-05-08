import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';
import '../../../core/error/failure.dart';

class DeleteCallsUseCase{
  DeleteCallsUseCase(this.callRepository);
  final CallRepository callRepository;

  Future<Either<Failure, void>> deleteCalls({
    required String userId,
    required List<String> ids,

  })async{
    return await callRepository.deleteCalls(userId: userId, ids: ids);
  }
}