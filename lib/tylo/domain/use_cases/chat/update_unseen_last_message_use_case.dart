import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

import '../../../core/error/failure.dart';

class UpdateUnSeenLastMessageUseCase{
  UpdateUnSeenLastMessageUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> updateUnSeenLastMessage({
    required String senderId,
    required String receiverId,
  })async{
    return await chatRepository.updateUnSeenLastMessage(
        senderId: senderId,
        receiverId: receiverId,
    );
  }

}