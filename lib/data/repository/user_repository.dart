import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:path/path.dart' as path;

class UserRepository {
  Future<void> saveUserData(User user) async {
    // Firestore 인스턴스
    final firestore = FirebaseFirestore.instance;

    // 저장할 데이터 (userId 제외)
    final userData = {
      "image": user.image,
      "local": user.local,
      "localCode": user.localCode,
      "nickname": user.nickname,
      "password": user.password,
      "phone": user.phone,
      "pet": {
        "petName": user.pet.petName,
        "petAge": user.pet.petAge,
        "petDogCat": user.pet.petDogCat,
        "petInformation": user.pet.petInformation,
      }
    };

    // Firestore의 Users 컬렉션에 문서 추가 (userId를 문서 이름으로 사용)
    await firestore.collection("Users").doc(user.userId).set(userData);
  }

  // Firebase Storage에 이미지 업로드
  Future<String> uploadImageToFirebase(XFile image) async {
    try {
      // 파일명 생성
      String fileName = path.basename(image.path);

      // Firebase Storage 경로 지정 및 업로드 Reference
      Reference storageRef =
          FirebaseStorage.instance.ref().child('users/$fileName');
      UploadTask uploadTask = storageRef.putFile(File(image.path));

      // 업로드 완료 후 URL 가져오기
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception('이미지 업로드 실패: $e');
    }
  }
}
