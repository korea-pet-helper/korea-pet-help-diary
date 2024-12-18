import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/firebase_options.dart';
import 'package:korea_pet_help_diary/ui/pages/profile_fix/dummy_page.dart';
import 'package:korea_pet_help_diary/ui/pages/profile_fix/profile_fix_page.dart';
import 'package:korea_pet_help_diary/ui/pages/theme/theme.dart';
import 'package:korea_pet_help_diary/ui/pages/login/login_page.dart';

void main() async {
  // runApp 실행 전 비동기 함수 사용해서 데이터 초기화할 때 사용
  WidgetsFlutterBinding.ensureInitialized();

  // firebase 설정
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ProviderScope 추가
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: LoginPage(),
    );
  }
}
