import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

import '../../../core/error/failure.dart';

class UpdateUserTypingStatusUseCase{
  UpdateUserTypingStatusUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> updateUserTypingStatus({
    required String senderId,
    required bool isTyping,
  })async{
    return await chatRepository.updateUserTypingStatus(senderId: senderId, isTyping: isTyping);
  }

}