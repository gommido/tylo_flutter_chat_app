import '../../domain/entities/app_user.dart';

class AppUserModel extends AppUser{
    AppUserModel({
      required super.id,
      required super.name,
      required super.phone,
      required super.photo,
      required super.bio,
      super.lastSeen,
      required super.createdAt,
      required super.token,
      required super.currentChatRoom,
      required super.isTyping,
      required super.blockList,
      required super.whoBlockMeList,
      required super.contacts,
      required super.onlineVisibility,
      required super.photoVisibility,
    });


  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      id: json["id"],
      name: json["name"],
      photo: json["photo"],
      phone: json["phone"],
      bio: json["bio"],
      lastSeen: json["lastSeen"],
      createdAt: json["createdAt"],
      token: json["token"],
      currentChatRoom: json["currentChatRoom"],
      isTyping: json["isTyping"],
      blockList: List<String>.from(json["blockList"]),
      whoBlockMeList: List<String>.from(json["whoBlockMeList"]),
      contacts: List<String>.from(json["contacts"]),
      onlineVisibility: json["onlineVisibility"],
      photoVisibility: json["photoVisibility"],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "photo": photo,
      "phone": phone,
      "bio": bio,
      "lastSeen": lastSeen,
      "createdAt": createdAt,
      "token": token,
      "currentChatRoom": currentChatRoom,
      "isTyping": isTyping,
      "blockList": blockList.map((blocked) => blocked).toList(),
      "whoBlockMeList": whoBlockMeList.map((blockMe) => blockMe).toList(),
      "contacts": contacts.map((contact) => contact).toList(),
      "onlineVisibility": onlineVisibility,
      "photoVisibility": photoVisibility,
    };
  }

}