import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMessage {
  final String messageId;
  final String messageText;
  final String sentBy;
  final String senderName;
  final String senderImage;
  final Timestamp messageTime;
  final String messageType;
  String? videoMessageThumbnail;
  int? voiceNoteDuration;

  GroupMessage(
      {
        required this.messageId,
        required this.messageText,
        required this.senderImage,
        required this.senderName,
        required this.messageTime,
        required this.sentBy,
        required this.messageType,
        this.videoMessageThumbnail,
        this.voiceNoteDuration,
      });
}