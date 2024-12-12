import 'package:flutter/material.dart';

// 프로필 사진 위젯
class UserProfileImage extends StatelessWidget {
  double size; // 사진 크기
  String imageUrl; // 사진 url

  UserProfileImage({required this.size, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        height: size,
        width: size,
        fit: BoxFit.fill,
      ),
    );
  }
}
