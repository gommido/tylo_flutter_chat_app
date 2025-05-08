
import 'package:tylo/tylo/domain/repositories/call_repository/call_repository.dart';
import '../../entities/call.dart';

class GetMyCallsUseCase{
  GetMyCallsUseCase(this.callRepository);
  final CallRepository callRepository;

  Stream<List<Call>> getMyCalls({
    required String userId,
  }){
    return callRepository.getMyCalls(userId: userId );
  }

}