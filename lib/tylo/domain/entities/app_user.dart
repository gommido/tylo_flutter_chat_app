
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser
{
  final String id;
  final String name;
  final String phone;
  final String photo;
  final String bio;
  Timestamp? lastSeen;
  final String token;
  final Timestamp createdAt;
  final String currentChatRoom;
  final bool isTyping;
  final List<dynamic> blockList;
  final List<dynamic> whoBlockMeList;
  final List<dynamic> contacts;
  final String onlineVisibility;
  final String photoVisibility;

  AppUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.photo,
    required this.bio,
    required this.lastSeen,
    required this.createdAt,
    required this.token,
    required this.currentChatRoom,
    required this.isTyping,
    required this.blockList,
    required this.whoBlockMeList,
    required this.contacts,
    required this.onlineVisibility,
    required this.photoVisibility,

  });

}
