import 'package:flutter/material.dart';
import 'package:korea_pet_help_diary/ui/pages/home/home_page.dart';
import 'package:korea_pet_help_diary/ui/pages/join/join_page.dart';
import 'package:korea_pet_help_diary/ui/pages/theme/theme.dart';
import 'package:korea_pet_help_diary/util/snackbar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/welcome.png'),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: '이메일',
              ),
            ),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                bool loginSuccess = true;

                if (loginSuccess) {
                  showCustomSnackBar(context, '로그인 성공');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()), // 로그인 성공 시 홈 페이지로 이동
                  );
                } else {
                  showCustomSnackBar(context, '로그인 실패');
                }
              },
              child: const Text('로그인'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JoinPage()), // 회원가입 페이지로 이동
                );
              },
              child: const Text('계정이 없다면? 회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
