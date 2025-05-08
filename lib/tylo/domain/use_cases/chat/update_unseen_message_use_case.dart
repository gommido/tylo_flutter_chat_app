import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

import '../../../core/error/failure.dart';

class UpdateUnSeenMessageUseCase{
  UpdateUnSeenMessageUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> updateUnSeenMessages({
    required String sentTo,
    required String sentBy,
    required String secondUserId,

  })async{
    return await chatRepository.updateUnSeenMessages(
      sentBy: sentBy,
      sentTo: sentTo,
      secondUserId: secondUserId,
    );
  }

}