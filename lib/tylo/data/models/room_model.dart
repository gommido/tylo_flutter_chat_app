import 'package:tylo/tylo/domain/entities/room.dart';


class RoomModel extends Room{
  RoomModel({
    required super.id,
    required super.callReceiverId,
    required super.callerId,
    required super.callerName,
    required super.callerImage,
    required super.lastCallTime,
    required super.lastCallDuration,
    required super.isRespond,

  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json["id"],
      callReceiverId: json["callReceiverId"],
      callerId: json["callerId"],
      callerName: json["callerName"],
      callerImage: json["callerImage"],
      lastCallTime: json["lastCallTime"],
      lastCallDuration: json["lastCallDuration"],
      isRespond: json["isRespond"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "callReceiverId": callReceiverId,
      "callerId": callerId,
      "callerName": callerName,
      "callerImage": callerImage,
      "lastCallTime": lastCallTime,
      "lastCallDuration": lastCallDuration,
      "isRespond": isRespond,

    };
  }

}