import 'package:korea_pet_help_diary/data/model/pet.dart';

class User {
  String userId;
  String image;
  String local;
  String localCode;
  String nickname;
  String password;
  String phone;
  List<String> chatRoomIds;
  //String petCharacter;
  Pet pet;

  User({
    required this.userId,
    required this.image,
    required this.local,
    required this.localCode,
    required this.nickname,
    required this.password,
    required this.phone,
    required this.chatRoomIds,
    //this.petCharacter = "Default Status",
    required this.pet, // Pet 객체
  });

  User.fromJson(Map<String, dynamic> map)
      : this(
          userId: map['userId'],
          image: map['image'],
          local: map['local'],
          localCode: map['localCode'],
          nickname: map['nickname'],
          password: map['password'],
          phone: map['phone'],
          chatRoomIds: List.from(map['chatRoomIds']),
          //petCharacter: map['petCharacter'],
          pet: Pet.fromJson(map['pet']),
        );

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'image': image,
      'local': local,
      'localCode': localCode,
      'nickname': nickname,
      'password': password,
      'phone': phone,
      'chatRoomIds': chatRoomIds,
      //'petCharacter':petCharacter,
      'pet': pet.toMap(),
    };
  }
}
