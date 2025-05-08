import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/core/error/failure.dart';
import 'package:tylo/tylo/core/utils/message_type_enum.dart';
import 'package:tylo/tylo/data/data_sources/remote/group_data_source/group_data_source.dart';
import 'package:tylo/tylo/data/models/group_message_model.dart';
import 'package:tylo/tylo/data/models/group_model.dart';
import 'package:tylo/tylo/domain/entities/group.dart';
import 'package:tylo/tylo/domain/entities/group_message.dart';
import 'package:tylo/tylo/domain/repositories/group_repository/group_repository.dart';

import '../../../core/error/exceptions.dart';

class GroupRepositoryImpl extends GroupRepository{
  GroupRepositoryImpl(this.groupDataSource);
  final GroupDataSource groupDataSource;


  @override
  Future<Either<Failure, void>> createGroup({
    required String id,
    required String name,
    required String ownerId,
    required String ownerName,
    required String ownerImage,
    required String image,
    required List<String> membersIds,
  })async {
    try{
      final createdAt = Timestamp.now();
      GroupModel group = GroupModel(
        id: id,
        name: name,
        ownerId: ownerId,
        ownerName: ownerName,
        ownerImage: ownerImage,
        createdAt: createdAt,
        membersIds: membersIds,
        lastMessage: '',
        lastMessageSenderId: '',
        lastMessageSenderName: '',
        image: image,
        bio: 'Hey, this is our group..',
        lastMessageTime: Timestamp.now(),
        lastMessageType: '',
      );
      final result = await groupDataSource.createGroup(id: id, groupData: group.toJson());
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }

  }

  @override
  Stream<Group?> getGroupDetails({required String id}) {
    final group =  groupDataSource.getGroupDetails(id: id,).map((event){
      if(event.exists){
        return GroupModel.fromJson(event.data() as Map<String, dynamic>);
      }
      return null;
    });
    return group;
  }

  @override
  Stream<List<Group>> getMyGroups({required String id}) {
    return groupDataSource.getMyGroups(id: id,).map((snapshot) {
      return snapshot.docs.map((doc) => GroupModel.fromJson(doc.data())).toList();
    });
  }

  @override
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

  })async {
    try{
      final messageTime = Timestamp.now();
      GroupMessageModel groupMessage = GroupMessageModel(
        senderName: senderName,
          senderImage: senderImage,
          messageText: messageText,
          messageTime: messageTime,
          sentBy: sentBy,
          messageType: messageType.type,
          messageId: messageId,
        videoMessageThumbnail: videoMessageThumbnail,
        voiceNoteDuration: voiceNoteDuration,
      );
      final result = await groupDataSource.sendGroupMessage(groupId: groupId, messageId: messageId, message: groupMessage.toJson());
      return Right(result);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Stream<List<GroupMessage>> getGroupMessages({required String groupId}) {
    return groupDataSource.getGroupMessages(groupId: groupId).map((snapshot) {
      if(snapshot.docs.isEmpty){
        return [];
      }
      return snapshot.docs.map((doc) => GroupMessageModel.fromJson(doc.data())).toList();
    });
  }


  @override
  Future<Either<Failure, void>> setGroupLastMessage({
    required String groupId,
    required String lastMessage,
    required String lastMessageSenderId,
    required String lastMessageSenderName,
    required Timestamp messageTime,
    required MessageType messageType,
  })async {
    try{
      final result = await groupDataSource.setGroupLastMessage(
          groupId: groupId,
          message: {
            'lastMessage': lastMessage,
            'lastMessageSenderId': lastMessageSenderId,
            'lastMessageSenderName': lastMessageSenderName,
            'lastMessageTime': messageTime,
            'lastMessageType': messageType.type,
          },
      );
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateGroupMessage({required String groupId, required String messageId, required String field, String? value}) async{
    try{
      final result = await groupDataSource.updateGroupMessage(
          groupId: groupId,
          messageId: messageId,
          message: {
            field: value,
          });
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }


  @override
  Future<Either<Failure, void>> addOrRemoveContactFromGroup({
    required String groupId,
    required List<String> members,
    required bool isAdding
  })async {
    try{
      final result = await groupDataSource.addOrRemoveContactFromGroupUseCase(groupId: groupId, groupMember: {
        'membersIds': isAdding ? FieldValue.arrayUnion(members) : FieldValue.arrayRemove(members),
      });
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }


  @override
  Future<Either<Failure, void>> updateGroupData({
    required String id,
    required String field,
    dynamic value,
})async {
    try{
      final result =  await groupDataSource.updateGroupData(
          id: id,
          userData: {
            field: value,
          });
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroup({required String id}) async {
    try{
      final result =  await groupDataSource.deleteGroup(id: id,);
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGroupMessage({required String groupId, required List<String> ids})async {
    try{
      final result =  await groupDataSource.deleteGroupMessage(groupId: groupId, ids: ids);

      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }





}