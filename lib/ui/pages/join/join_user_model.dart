class User {
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

  String userId;
  String image;
  String local;
  String localCode;
  String nickname;
  String password;
  String phone;
  Pet pet;

  // Firestore에 저장하기 위한 Map 변환 메서드
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'image': image,
      'local': local,
      'localCode': localCode,
      'nickname': nickname,
      'password': password,
      'phone': phone,
      'pet': pet.toMap() // Pet 객체를 Map으로 변환
    };
  }
}

class Pet {
  Pet({
    this.petName = '',
    this.petAge = 0,
    this.petDogCat = '',
    this.petInformation = '',
  });

  String petName;
  int petAge;
  String petDogCat;
  String petInformation;

  // Firestore에 저장하기 위한 Map 변환 메서드
  Map<String, dynamic> toMap() {
    return {
      'petName': petName,
      'petAge': petAge,
      'petDogCat': petDogCat,
      'petInformation': petInformation,
    };
  }
}
