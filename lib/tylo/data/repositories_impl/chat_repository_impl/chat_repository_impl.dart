import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/core/error/failure.dart';
import 'package:tylo/tylo/core/utils/message_type_enum.dart';
import 'package:tylo/tylo/data/data_sources/remote/chat_data_source/chat_data_source.dart';
import 'package:tylo/tylo/data/models/chat_message_model.dart';
import 'package:tylo/tylo/data/models/last_message_model.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/domain/entities/last_message.dart';
import 'package:tylo/tylo/domain/repositories/chat_repository/chat_repository.dart';

import '../../../core/error/exceptions.dart';

class ChatRepositoryImpl implements ChatRepository{
  ChatRepositoryImpl(this.chatDataSource,);
  final ChatDataSource chatDataSource;

  @override
  Future<Either<Failure, Unit>> sendMessage({
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
    try{
      ChatMessageModel senderMessage = ChatMessageModel(
        messageText: messageText,
        sentBy: sentBy,
        messageTime: messageTime,
        messageType: messageType.type,
        messageId: messageId,
        isSeen: false,
        videoMessageThumbnail: videoMessageThumbnail,
        voiceNoteDuration: voiceNoteDuration,
        imageLowQuality: imageLowQuality,
        videoCallDuration: voiceNoteDuration,
      );

      ChatMessageModel receiverMessage = ChatMessageModel(
        messageText: messageText,
        sentBy: sentBy,
        messageTime: messageTime,
        messageType: messageType.type,
        messageId: messageId,
        isSeen: false,
        videoMessageThumbnail: videoMessageThumbnail,
        voiceNoteDuration: voiceNoteDuration,
        imageLowQuality: imageLowQuality,
        videoCallDuration: voiceNoteDuration,
      );

      await chatDataSource.sendMessage(messageId: messageId, sentBy: sentBy, sentTo: sentTo, token: token, message: senderMessage.toJson());
      await chatDataSource.sendMessage(messageId: messageId, sentBy: sentTo, sentTo: sentBy, token: token, message: receiverMessage.toJson());
      return const Right(unit);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Stream<List<ChatMessage>> getChatMessages({
    required String sentBy,
    required String sentTo,
}){
    return chatDataSource.getChatMessages(sentTo: sentTo, sentBy: sentBy,).map((snapshot) {
      if(snapshot.docs.isEmpty){
        return [];
      }
      return snapshot.docs.map((doc) => ChatMessageModel.fromJson(doc.data())).toList();
    });
  }

  @override
  Stream<List<LastMessage>> getMyChatsLastMessages({required String  userId}) {
    return chatDataSource.getMyChatsLastMessages(userId: userId).map((snapshot){
      if(snapshot.docs.isNotEmpty){
        return snapshot.docs.map((doc) => LastMessageModel.fromJson(doc.data())).toList();
      }
      return [];
    });
  }



  @override
  Future<Either<Failure, Unit>> setLastMessage({
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
    try{
      LastMessageModel senderMessage = LastMessageModel(
          sentBy: sentBy,
          secondUserId: secondUserId,
          secondUserName: secondUserName,
          secondUserImage: secondUserImage,
          messageText: lastMessage,
          messageTime: messageTime,
          messageType: messageType.type,
          isSeen: false,
          isTyping: false,
        firstUserPhotoVisibility: firstUserPhotoVisibility,
        secondUserPhotoVisibility: secondUserPhotoVisibility,
      );

      LastMessageModel receiverMessage = LastMessageModel(
        sentBy: sentBy,
        secondUserId: sentBy,
        secondUserName: firstUserName,
        secondUserImage: firstUserImage,
        messageText: lastMessage,
        messageTime: messageTime,
        messageType: messageType.type,
        isSeen: false,
        isTyping: false,
        firstUserPhotoVisibility: secondUserPhotoVisibility,
        secondUserPhotoVisibility: firstUserPhotoVisibility,
      );


      await chatDataSource.setLastMessage(
        firstUserId: sentBy,
          secondUserId: secondUserId,
          messageData: senderMessage.toJson()
      );

      await chatDataSource.setLastMessage(
          firstUserId: secondUserId,
          secondUserId: sentBy,
          messageData: receiverMessage.toJson()
      );

      return const Right(unit);
    }on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }



  @override
  Future<Either<Failure, void>> updateUserTypingStatus({required String senderId,  required bool isTyping})async {
    try{
      final result = await chatDataSource.updateUserTypingStatus(
          senderId: senderId,
          data: {
            'isTyping': isTyping,
          }
      );
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateLastMessageTypingStatus({
    required String receiverId,
    required String chatRoomId,
    required bool isTyping,
  })async {
    try{
      final result = await chatDataSource.updateLastMessageTypingStatus(
          receiverId: receiverId,
          chatRoomId: chatRoomId,
          data: {
            'isTyping': isTyping,
          }
      );
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }


  @override
  Future<Either<Failure, Unit>> updateUnSeenMessages({
    required String sentTo,
    required String sentBy,
    required String secondUserId,

})async {
    try{
      await chatDataSource.updateUnSeenMessages(
        sentTo: sentTo,
        sentBy: sentBy,
        secondUserId: secondUserId,
      );
      await chatDataSource.updateUnSeenMessages(
        sentTo: sentBy,
        sentBy: sentTo,
        secondUserId: secondUserId,
      );
      return const Right(unit);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUnSeenLastMessage({required String senderId, required String receiverId})async {
    try{
     await chatDataSource.updateUnSeenLastMessage(
          senderId: senderId,
          receiverId: receiverId,
          data: {
            'isSeen': true,
          }
      );
     await chatDataSource.updateUnSeenLastMessage(
         senderId: receiverId,
         receiverId: senderId,
         data: {
           'isSeen': true,
         }
     );
      return const Right(unit);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateMessage({
    required String firstUserId,
    required String secondUserId,
    required String messageId,
    required String field,
    dynamic value,
  })async {
    try{
      final result = await chatDataSource.updateMessage(firstUserId: firstUserId, secondUserId: secondUserId, messageId: messageId,
          data: {
            field: value,
          }
      );
      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage({
    required String firstUserId,
    required String secondUserId,
    required List<String> ids,
})async {
    try{
      final result =  await chatDataSource.deleteMessage(firstUserId: firstUserId, secondUserId: secondUserId, ids: ids);

      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Stream<List<ChatMessage>> getUnSeenMessagesCount({
    required String senderId,
    required String receiverId,
}) {
    return chatDataSource.getUnSeenMessagesCount(senderId: senderId, receiverId: receiverId,).map((snapshot) {
      if(snapshot.docs.isEmpty){
        return [];
      }
      return snapshot.docs.map((doc) => ChatMessageModel.fromJson(doc.data())).toList();
    });
  }

  @override
  Stream<List<LastMessage>> getUnSeenNewChatsCount({required String userId,}) {
    return chatDataSource.getUnSeenNewChatsCount(userId: userId,).map((snapshot) {
      if(snapshot.docs.isEmpty){
        return [];
      }
      return snapshot.docs.map((doc) => LastMessageModel.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<Either<Failure, void>> deleteChat({required String firstUserId, required String secondUserId}) async {
    try{
      final result =  await chatDataSource.deleteChat(firstUserId: firstUserId, secondUserId: secondUserId);

      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChatLastMessages({
    required String userId,
    required List<String> ids,
  }) async {
    try{
      final result =  await chatDataSource.deleteChatLastMessages(userId: userId, ids: ids);

      return Right(result);
    } on FireBaseExceptions catch(error){
      return Left(FireBaseFailure(message: error.errorMessage.message));
    }
  }





}