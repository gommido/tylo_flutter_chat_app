import 'package:tylo/tylo/domain/entities/group.dart';


class GroupModel extends Group {
  GroupModel({
    required super.id,
    required super.name,
    required super.ownerId,
    required super.ownerName,
    required super.ownerImage,
    required super.createdAt,
    required super.membersIds,
    required super.image,
    required super.bio,
    required super.lastMessage,
    required super.lastMessageSenderName,
    required super.lastMessageSenderId,
    required super.lastMessageTime,
    required super.lastMessageType,

  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      ownerName: json['ownerName'],
      ownerImage: json['ownerImage'],
      createdAt: json['createdAt'],
      membersIds: List<String>.from(json["membersIds"]),
      image: json['image'],
      bio: json['bio'],
      lastMessage: json['lastMessage'],
      lastMessageSenderId: json['lastMessageSenderId'],
      lastMessageSenderName: json['lastMessageSenderName'],
      lastMessageTime: json['lastMessageTime'],
      lastMessageType: json['lastMessageType'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'ownerImage': ownerImage,
      'createdAt': createdAt,
      "membersIds": membersIds.map((memberId) => memberId).toList(),
      'image': image,
      'bio': bio,
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageSenderName': lastMessageSenderName,
      'lastMessageTime': lastMessageTime,
      'lastMessageType': lastMessageType,

    };
  }
}