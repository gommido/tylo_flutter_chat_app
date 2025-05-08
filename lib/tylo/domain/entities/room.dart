import 'package:cloud_firestore/cloud_firestore.dart';


class Room {
  final String id;
  final String callReceiverId;
  final String callerId;
  final String callerName;
  final String callerImage;
  final Timestamp lastCallTime;
  final String lastCallDuration;
  final bool isRespond;

  Room(
      {
        required this.id,
        required this.callReceiverId,
        required this.callerId,
        required this.callerName,
        required this.callerImage,
        required this.lastCallTime,
        required this.lastCallDuration,
        required this.isRespond,
      });

}