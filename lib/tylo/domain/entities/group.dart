
import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  final String id;
  final String name;
  final String ownerId;
  final String ownerName;
  final String ownerImage;
  final Timestamp createdAt;
  final List<dynamic> membersIds;
  final String image;
  final String bio;
  final String lastMessage;
  final String lastMessageSenderId;
  final String lastMessageSenderName;
  final Timestamp lastMessageTime;
  final String lastMessageType;

  Group({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.ownerName,
    required this.ownerImage,
    required this.createdAt,
    required this.membersIds,
    required this.image,
    required this.bio,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.lastMessageSenderName,
    required this.lastMessageTime,
    required this.lastMessageType,

  });

}