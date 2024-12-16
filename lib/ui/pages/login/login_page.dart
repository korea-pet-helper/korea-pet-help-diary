import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:korea_pet_help_diary/ui/pages/home/home_page.dart';
import 'package:korea_pet_help_diary/ui/pages/join/join_page.dart';
import 'package:korea_pet_help_diary/util/snackbar.dart';

// 로그인 페이지 클래스
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 텍스트 컨트롤러 선언
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false; // 로그인 버튼 활성화 상태

  // 아이디와 비밀번호 입력 상태에 따라 버튼 활성화 상태를 업데이트하는 메서드
  void _updateButtonState() {
    setState(() {
      isButtonEnabled =
          idController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  // 사용자 로그인 메서드
  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      // 폼의 유효성을 검사
      try {
        // Firestore에서 아이디로 유저 문서를 찾음
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(idController.text)
            .get();
        // 유저 문서가 존재하고 비밀번호가 일치하는지 확인
        if (userDoc.exists && userDoc['password'] == passwordController.text) {
          showCustomSnackBar(context, '로그인 성공');

          // 로컬코드 가져오기
          String localCode = userDoc['localCode'];

          // 홈 페이지로 이동하면서 로컬코드 전달
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(localCode: localCode),
            ),
          );
        } else {
          showCustomSnackBar(context, '아이디 또는 비밀번호가 잘못되었습니다.');
        }
      } catch (e) {
        showCustomSnackBar(context, '로그인 실패: ${e.toString()}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    idController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    idController.removeListener(_updateButtonState); // 아이디 입력 상태 변경 리스너 제거
    passwordController
        .removeListener(_updateButtonState); // 비밀번호 입력 상태 변경 리스너 제거
    idController.dispose(); // 아이디 컨트롤러 해제
    passwordController.dispose(); // 비밀번호 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 로고 이미지
              Image.asset(
                'assets/images/welcome.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 20),
              // 아이디 입력 필드
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: '아이디',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '아이디를 입력하세요.';
                  }
                  return null;
                },
              ),
              // 비밀번호 입력 필드
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // 로그인 버튼
              ElevatedButton(
                onPressed:
                    isButtonEnabled ? _loginUser : null, // 버튼 활성화 상태에 따라 로그인 시도
                child: const Text('로그인'),
              ),
              // 회원가입 페이지로 이동 버튼
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
      ),
    );
  }
}
