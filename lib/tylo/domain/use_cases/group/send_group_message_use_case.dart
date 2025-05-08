import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/group_repository/group_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';
import '../../repositories/chat_repository/chat_repository.dart';

class SendGroupMessageUseCase{
  SendGroupMessageUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Future<Either<Failure, void>> sendGroupMessage({
    required String messageText,
    required String sentBy,
    required String senderName,
    required String senderImage,
    required String groupId,
    required String messageId,
    required Timestamp messageTime,
    required MessageType messageType,
    String? videoMessageThumbnail,
    int? voiceNoteDuration,
  })async {
    return await groupRepository.sendGroupMessage(messageText: messageText, sentBy: sentBy, senderName: senderName, senderImage: senderImage, groupId: groupId, messageId: messageId, messageType: messageType, messageTime: messageTime, videoMessageThumbnail: videoMessageThumbnail, voiceNoteDuration: voiceNoteDuration,);

  }
}