import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/repositories/group_repository/group_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';

class SetGroupLastMessageUseCase{
  SetGroupLastMessageUseCase(this.groupRepository);
  final GroupRepository groupRepository;

  Future<Either<Failure, void>> setGroupLastMessage({
    required String groupId,
    required String lastMessage,
    required String lastMessageSenderId,
    required String lastMessageSenderName,
    required Timestamp messageTime,
    required MessageType messageType,
  })async {
    return await groupRepository.setGroupLastMessage(groupId: groupId, lastMessage: lastMessage, lastMessageSenderId: lastMessageSenderId,lastMessageSenderName: lastMessageSenderName , messageTime: messageTime, messageType: messageType);
  }

}