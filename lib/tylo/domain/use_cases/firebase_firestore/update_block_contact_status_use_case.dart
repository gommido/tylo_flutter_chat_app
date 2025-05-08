import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';
import 'package:tylo/tylo/domain/repositories/firestore_repository/firestore_repository.dart';

import '../../../core/error/failure.dart';

class UpdateBlockContactStatusUseCase{
  UpdateBlockContactStatusUseCase(this.fireStoreRepository);
  final FireStoreRepository fireStoreRepository;

  Future<Either<Failure, void>> updateBlockContactStatus({
    required String id,
    required String blockedId,
    required bool isBlocking,
  })async{
    return await fireStoreRepository.updateBlockContactStatus(id: id, blockedId: blockedId, isBlocking: isBlocking);
  }

}