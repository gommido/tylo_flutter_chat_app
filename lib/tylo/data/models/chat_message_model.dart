
import '../../domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  ChatMessageModel({
    required super.sentBy,
    required super.messageText,
    required super.messageTime,
    required super.messageType,
    required super.messageId,
    required super.isSeen,
    required super.videoMessageThumbnail,
    required super.voiceNoteDuration,
    required super.imageLowQuality,
    required super.videoCallDuration,

  });


  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      messageText: json["messageText"],
      sentBy: json["sentBy"],
      messageTime: json["messageTime"],
      messageType: json["messageType"],
      messageId: json["messageId"],
      isSeen: json["isSeen"],
      videoMessageThumbnail: json["videoMessageThumbnail"],
      voiceNoteDuration: json["voiceNoteDuration"],
      imageLowQuality: json["imageLowQuality"],
      videoCallDuration: json["videoCallDuration"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
     // 'chatId': chatId,
      'messageText': messageText,
      'sentBy': sentBy,
      'messageTime': messageTime,
      'messageType': messageType,
      'messageId': messageId,
      'isSeen': isSeen,
      'videoMessageThumbnail': videoMessageThumbnail,
      'voiceNoteDuration': voiceNoteDuration,
      'imageLowQuality': imageLowQuality,
      'videoCallDuration': videoCallDuration,


    };
  }


}