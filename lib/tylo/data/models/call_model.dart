import 'package:tylo/tylo/domain/entities/call.dart';

class CallModel extends Call{
  CallModel({
    required super.id,
    required super.secondUserId,
    required super.secondUserName,
    required super.secondUserImage,
    required super.callCreated,
    required super.isDialed,
    required super.duration,

  });

  factory CallModel.fromJson(Map<String, dynamic> json) {
    return CallModel(
      id: json["id"],
      secondUserId: json["secondUserId"],
      secondUserName: json["secondUserName"],
      secondUserImage: json["secondUserImage"],
      callCreated: json["callCreated"],
      isDialed: json["isDialed"],
      duration: json["duration"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "secondUserId": secondUserId,
      "secondUserName": secondUserName,
      "secondUserImage": secondUserImage,
      "callCreated": callCreated,
      "isDialed": isDialed,
      "duration": duration,

    };
  }

}