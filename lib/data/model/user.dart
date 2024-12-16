import 'package:korea_pet_help_diary/data/model/pet.dart';

class User {
  String userId;
  String image;
  String local;
  String localCode;
  String nickname;
  String password;
  String phone;
  Pet pet;

  User({
    required this.userId,
    required this.image,
    required this.local,
    required this.localCode,
    required this.nickname,
    required this.password,
    required this.phone,
    required this.pet, // Pet 객체
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'image': image,
      'local': local,
      'localCode': localCode,
      'nickname': nickname,
      'password': password,
      'phone': phone,
      'pet': pet.toMap(),
    };
  }
}
