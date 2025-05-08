import 'package:tylo/tylo/domain/entities/app_contact.dart';

class AppContactModel extends AppContact{
  AppContactModel({
      required super.id,
    required super.name,
    required super.phone,
    required super.image,
    required super.photoVisibility,
    required super.whoBlockMeList,

  });


  factory AppContactModel.fromJson(Map<String, dynamic> json) {
    return AppContactModel(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      image: json["image"],
      photoVisibility: json["photoVisibility"],
      whoBlockMeList: List<String>.from(json["whoBlockMeList"]),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'image': image,
      'photoVisibility': photoVisibility,
      "whoBlockMeList": whoBlockMeList.map((contact) => contact).toList(),

    };
  }

}