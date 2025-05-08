import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

import '../../../core/error/failure.dart';

class UpdateMessageUseCase{
  UpdateMessageUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> updateMessage({
    required String firstUserId,
    required String secondUserId,
    required String messageId,
    required String field,
    dynamic value,
  })async{
    return await chatRepository.updateMessage(firstUserId: firstUserId, secondUserId: secondUserId, messageId: messageId, field: field, value: value);
  }

}