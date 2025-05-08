import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../repositories/chat_repository/chat_repository.dart';

class SendMessageUseCase{
  SendMessageUseCase(this.chatRepository);
  final ChatRepository chatRepository;

  Future<Either<Failure, void>> sendMessage({
    required String messageId,
    required String sentBy,
    required String sentTo,
    required String messageText,
    required Timestamp messageTime,
    required MessageType messageType,
    required String token,
    String? videoMessageThumbnail,
    int? voiceNoteDuration,
    String? imageLowQuality,
    int? videoCallDuration,

  })async {
    return await chatRepository.sendMessage(messageId: messageId, sentBy: sentBy, sentTo: sentTo, messageText: messageText, messageTime: messageTime, messageType: messageType, token: token, imageLowQuality: imageLowQuality, videoMessageThumbnail: videoMessageThumbnail, voiceNoteDuration: voiceNoteDuration, videoCallDuration: videoCallDuration,);
  }

  /*
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String messageText,
    required String sentBy,
    required String messageId,
    required Timestamp messageTime,
    required MessageType messageType,
    required String token,
    String? videoMessageThumbnail,
    int? voiceNoteDuration,

  })async {
    return await chatRepository.sendMessage(messageText: messageText, chatId: chatId, sentBy: sentBy,messageId: messageId, messageType: messageType, messageTime: messageTime, token: token, videoMessageThumbnail: videoMessageThumbnail, voiceNoteDuration: voiceNoteDuration);
  }

   */

}