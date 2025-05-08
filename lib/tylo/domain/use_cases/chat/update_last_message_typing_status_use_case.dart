import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

import '../../../core/error/failure.dart';

class UpdateLastMessageTypingStatusUseCase{
  UpdateLastMessageTypingStatusUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> updateLastMessageTypingStatus({
    required String receiverId,
    required String chatRoomId,
    required bool isTyping,
  })async{
    return await chatRepository.updateLastMessageTypingStatus(receiverId: receiverId, chatRoomId: chatRoomId, isTyping: isTyping);
  }

}