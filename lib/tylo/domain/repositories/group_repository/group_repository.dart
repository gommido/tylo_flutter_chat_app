import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/entities/group.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';

abstract class GroupRepository{

  Future<Either<Failure, void>> createGroup({
    required String id,
    required String name,
    required String ownerId,
    required String ownerName,
    required String ownerImage,
    required String image,
    required List<String> membersIds,
  });

  Stream<Group?> getGroupDetails({
    required String id,
  });

  Stream<List<Group>> getMyGroups({
    required String id,
  });

  Future<Either<Failure, void>> sendGroupMessage({
    required String sentBy,
    required String senderName,
    required String senderImage,
    required String groupId,
    required String messageText,
    required String messageId,
    required Timestamp messageTime,
    required MessageType messageType,
    String? videoMessageThumbnail,
    int? voiceNoteDuration,

  });

  Stream<List<GroupMessage>> getGroupMessages({
    required String groupId,
  });

  Future<Either<Failure, void>> setGroupLastMessage({
    required String groupId,
    required String lastMessage,
    required String lastMessageSenderName,
    required String lastMessageSenderId,
    required Timestamp messageTime,
    required MessageType messageType,
  });

  Future<Either<Failure, void>> updateGroupMessage({
    required String groupId,
    required String messageId,
    required String field,
    String? value,
  });


  Future<Either<Failure, void>> addOrRemoveContactFromGroup({
    required String groupId,
    required List<String> members,
    required bool isAdding,
  });

  Future<Either<Failure, void>> updateGroupData({
    required String id,
    required String field,
    dynamic value,
  });

  Future<Either<Failure, void>> deleteGroupMessage({
    required String groupId,
    required List<String> ids,
  });

  Future<Either<Failure, void>> deleteGroup({
    required String id,
  });



}