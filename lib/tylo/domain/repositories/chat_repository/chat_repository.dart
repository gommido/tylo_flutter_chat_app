import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tylo/tylo/domain/entities/chat_message.dart';
import 'package:tylo/tylo/domain/entities/last_message.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/message_type_enum.dart';

abstract class ChatRepository{

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

  });

  Stream<List<ChatMessage>> getChatMessages({
    required String sentBy,
    required String sentTo,
  });

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

  });


  Stream<List<LastMessage>> getMyChatsLastMessages({required String userId});


  Future<Either<Failure, void>> updateUserTypingStatus({
    required String senderId,
    required bool isTyping,
  });

  Future<Either<Failure, void>> updateLastMessageTypingStatus({
    required String receiverId,
    required String chatRoomId,
    required bool isTyping,
  });

  Future<Either<Failure, void>> updateUnSeenMessages({
    required String sentTo,
    required String sentBy,
    required String secondUserId,

  });


  Future<Either<Failure, void>> updateUnSeenLastMessage({
    required String senderId,
    required String receiverId,
  });

  Future<Either<Failure, void>> updateMessage({
    required String firstUserId,
    required String secondUserId,
    required String messageId,
    required String field,
    dynamic value,
  });

  Future<Either<Failure, void>> deleteMessage({
    required String firstUserId,
    required String secondUserId,
    required List<String> ids,
  });

  Stream<List<ChatMessage>> getUnSeenMessagesCount({
    required String senderId,
    required String receiverId,
  });

  Stream<List<LastMessage>> getUnSeenNewChatsCount({
    required String userId,
  });

  Future<Either<Failure, void>> deleteChatLastMessages({
    required String userId,
    required List<String> ids,
  });

  Future<Either<Failure, void>> deleteChat({
    required String firstUserId,
    required String secondUserId,
  });



}