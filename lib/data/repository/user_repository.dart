import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:korea_pet_help_diary/data/model/pet.dart';
import 'package:korea_pet_help_diary/data/model/user.dart';
import 'package:path/path.dart' as path;

class UserRepository {
  Future<void> saveUserData(User user) async {
    // Firestore 인스턴스
    final firestore = FirebaseFirestore.instance;

    // Firestore의 Users 컬렉션에 문서 추가 (userId를 문서 이름으로 사용)
    await firestore.collection("Users").doc(user.userId).set(user.toMap());
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

  Future<bool> insert ({
    required String userId, 
    required String local,
    required String localCode,
    required String nickname,
    required String phone,
    required String imageUrl,
    required Pet pet,
  }) async {
    //try if the environment is safe to conduct insert
    try {
      //fetch instance
      final firestore = FirebaseFirestore.instance;
      //collection reference
      final collectionRef = firestore.collection("Users");
      //document reference
      final docRef = collectionRef.doc();
      //writing the values
      docRef.set({
        'nickname': nickname,
        'imageUrl': imageUrl,
        'local': local,
        'localCode' : localCode,
        'Pet' : pet,
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> update({
    required String userId,
    required String nickname,
    required String imageUrl,
    required String local,
    required String localCode,
    required Pet pet,
  }) async {
    try{
      //fetch instance
      final firestore = FirebaseFirestore.instance;
      //collection reference
      final collectionRef = firestore.collection("Users");
      //document reference
      final docRef = collectionRef.doc();
      //writing the values
      docRef.update({
        'userID': userId,
        'nickname': nickname,
        'imageUrl': imageUrl,
        'local': local,
        'localCode' : localCode,
        'Pet' : pet,
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}
