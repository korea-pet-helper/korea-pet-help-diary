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
