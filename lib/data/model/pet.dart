class Pet {
  String petName;
  int petAge;
  String petDogCat;
  String petInformation;

  Pet({
    this.petName = '',
    this.petAge = 0,
    this.petDogCat = '',
    this.petInformation = '',
  });

  Pet.fromJson(Map<String, dynamic> map)
      : this(
          petName: map['petName'],
          petAge: map['petAge'],
          petDogCat: map['petDogCat'],
          petInformation: map['petInformation'],
        );

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
