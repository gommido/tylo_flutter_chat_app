import '../../domain/entities/group_message.dart';

class GroupMessageModel extends GroupMessage {
  GroupMessageModel({
    required super.senderName,
    required super.senderImage,
    required super.messageText,
    required super.messageTime,
    required super.sentBy,
    required super.messageType,
    required super.messageId,
    required super.videoMessageThumbnail,
    required super.voiceNoteDuration,

  });


  factory GroupMessageModel.fromJson(Map<String, dynamic> json) {
    return GroupMessageModel(
      senderName: json["senderName"],
      senderImage: json["senderImage"],
      messageText: json["messageText"],
      messageTime: json["messageTime"],
      sentBy: json["sentBy"],
      messageType: json["messageType"],
      messageId: json["messageId"],
      videoMessageThumbnail: json["videoMessageThumbnail"],
      voiceNoteDuration: json["voiceNoteDuration"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderName': senderName,
      'senderImage': senderImage,
      'messageText': messageText,
      'messageTime': messageTime,
      'sentBy': sentBy,
      'messageType': messageType,
      'messageId': messageId,
      'videoMessageThumbnail': videoMessageThumbnail,
      'voiceNoteDuration': voiceNoteDuration,

    };
  }


}