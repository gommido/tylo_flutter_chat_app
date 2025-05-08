import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String messageText;
  final String sentBy;
  final Timestamp messageTime;
  final String messageType;
  final String messageId;
  final bool isSeen;
  String? videoMessageThumbnail;
  int? voiceNoteDuration;
  String? imageLowQuality;
  int? videoCallDuration;

  ChatMessage(
      {
        required this.messageText,
        required this.sentBy,
        required this.messageTime,
        required this.messageType,
        required this.messageId,
        required this.isSeen,
        required this.videoMessageThumbnail,
        required this.voiceNoteDuration,
        required this.imageLowQuality,
        required this.videoCallDuration,

      });
}