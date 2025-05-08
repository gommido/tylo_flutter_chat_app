
import '../../domain/entities/last_message.dart';

class LastMessageModel extends LastMessage {

  LastMessageModel({
    required super.sentBy,
    required super.secondUserId,
    required super.secondUserName,
    required super.secondUserImage,
    required super.messageText,
    required super.messageTime,
    required super.messageType,
    required super.isSeen,
    required super.isTyping,
    required super.firstUserPhotoVisibility,
    required super.secondUserPhotoVisibility,

  });


  factory LastMessageModel.fromJson(Map<String, dynamic> json) {
    return LastMessageModel(
      sentBy: json["sentBy"],
     // senderName: json["senderName"],
      secondUserId: json["secondUserId"],
      secondUserName: json["secondUserName"],
      secondUserImage: json["secondUserImage"],
      messageText: json["messageText"],
      messageTime: json["messageTime"],
      messageType: json["messageType"],
      isSeen: json["isSeen"],
      isTyping: json["isTyping"],
      firstUserPhotoVisibility: json["firstUserPhotoVisibility"],
      secondUserPhotoVisibility: json["secondUserPhotoVisibility"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sentBy': sentBy,
      //'senderName': senderName,
      //'senderNImage': senderNImage,
      'secondUserId': secondUserId,
      'secondUserName': secondUserName,
      'secondUserImage': secondUserImage,
      'messageText': messageText,
      'messageTime': messageTime,
      'messageType': messageType,
      'isSeen': isSeen,
      'isTyping': isTyping,
      'firstUserPhotoVisibility': firstUserPhotoVisibility,
      'secondUserPhotoVisibility': secondUserPhotoVisibility,

    };
  }



}