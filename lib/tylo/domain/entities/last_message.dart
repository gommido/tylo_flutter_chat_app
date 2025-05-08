import 'package:cloud_firestore/cloud_firestore.dart';

class LastMessage {
  final String sentBy;
  final String secondUserId;
  final String secondUserName;
  final String secondUserImage;
  final String messageText;
  final Timestamp messageTime;
  final String messageType;
  final bool isSeen;
  final bool isTyping;
  final String firstUserPhotoVisibility;
  final String secondUserPhotoVisibility;


  LastMessage(
      {
        required this.sentBy,
        required this.secondUserId,
        required this.secondUserName,
        required this.secondUserImage,
        required this.messageText,
        required this.messageTime,
        required this.messageType,
        required this.isSeen,
        required this.isTyping,
        required this.firstUserPhotoVisibility,
        required this.secondUserPhotoVisibility,

      });
}