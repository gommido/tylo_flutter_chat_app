import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../repositories/chat_repository/chat_repository.dart';


class SetLastMessageUseCase{
  SetLastMessageUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> setLastMessage({
    required String sentBy,
    required String firstUserName,
    required String firstUserImage,
    required String secondUserId,
    required String secondUserName,
    required String secondUserImage,
    required String lastMessage,
    required Timestamp messageTime,
    required MessageType messageType,
    required String firstUserPhotoVisibility,
    required String secondUserPhotoVisibility,
  })async {
    return await chatRepository.setLastMessage(
        sentBy: sentBy,
        firstUserName: firstUserName,
        firstUserImage: firstUserImage,
        secondUserId: secondUserId,
        secondUserName: secondUserName,
        secondUserImage: secondUserImage,
        lastMessage: lastMessage,
        messageTime: messageTime,
        messageType: messageType,
      firstUserPhotoVisibility: firstUserPhotoVisibility,
      secondUserPhotoVisibility: secondUserPhotoVisibility,

    );
  }
}

