import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveUserData({
  required String userId,
  required String image,
  required String local,
  required String localCode,
  required String nickname,
  required String password,
  required String phone,
  required String petName,
  required int petAge,
  required String petDogCat,
  required String petInformation,
}) async {
  try {
    // Firestore 인스턴스
    final firestore = FirebaseFirestore.instance;

    // 저장할 데이터
    Map<String, dynamic> userData = {
      "image": image,
      "local": local,
      "localCode": localCode,
      "nickname": nickname,
      "password": password,
      "phone": phone,
      "pet": {
        "name": petName,
        "age": petAge,
        "dogcat": petDogCat,
        "information": petInformation,
      },
    };

    // Firestore의 Users 컬렉션에 문서 추가 (userId를 문서 이름으로 사용)
    await firestore.collection("Users").doc(userId).set(userData);

    print("User data saved successfully!");
  } catch (e) {
    print("Error saving user data: $e");
  }
}
