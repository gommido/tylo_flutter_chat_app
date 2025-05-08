import 'package:cloud_firestore/cloud_firestore.dart';


class Call {
  final String id;
  final String secondUserId;
  final String secondUserName;
  final String secondUserImage;
  final Timestamp callCreated;
  final bool isDialed;
  final int duration;

  Call(
      {
        required this.id,
        required this.secondUserId,
        required this.secondUserName,
        required this.secondUserImage,
        required this.callCreated,
        required this.isDialed,
        required this.duration,

      });

}