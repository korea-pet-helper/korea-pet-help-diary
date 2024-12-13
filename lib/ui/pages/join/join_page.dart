import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:korea_pet_help_diary/util/formatter.dart';
import 'firebase_user_creat.dart';

class JoinPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends ConsumerState<JoinPage> {
  String idError = ''; // 최소 글자수 미만일 때 사용
  String passwordError = ''; // 최소 글자수 미만일 때 사용

  // 컨트롤러 생성
  TextEditingController idTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController password2TextEditingController =
      TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController localTextEditingController = TextEditingController();

  @override
  void dispose() {
    // 컨트롤러 해제
    idTextEditingController.dispose();
    nameTextEditingController.dispose();
    passwordTextEditingController.dispose();
    password2TextEditingController.dispose();
    phoneTextEditingController.dispose();
    localTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원가입',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                buildInputField(
                  title: '아이디',
                  hintText: '아이디를 입력해 주세요',
                  textEditingController: idTextEditingController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(20), // 최대 글자수 제한
                  ],
                  onChanged: (value) {
                    setState(() {
                      idError = value.length < 5 ? '아이디는 최소 5자 이상이어야 합니다.' : '';
                    });
                  },
                  errorText: idError,
                ),
                buildInputField(
                  title: '이름',
                  hintText: '이름을 입력해 주세요',
                  textEditingController: nameTextEditingController,
                ),
                buildInputField(
                  title: '비밀번호',
                  hintText: '비밀번호를 입력해 주세요',
                  textEditingController: passwordTextEditingController,
                  obscureText: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16), // 최대 글자수 제한
                  ],
                  onChanged: (value) {
                    setState(() {
                      passwordError =
                          value.length < 8 ? '비밀번호는 최소 8자 이상이어야 합니다.' : '';
                    });
                  },
                  errorText: passwordError,
                ),
                buildInputField(
                  title: '비밀번호확인', // 비밀번호와 다를 시 에러 메시지 줘야 함.
                  hintText: '비밀번호를 다시 입력해 주세요',
                  textEditingController: password2TextEditingController,
                  obscureText: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
                buildInputField(
                  title: '전화번호',
                  hintText: '000-0000-0000',
                  textEditingController: phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능
                    PhoneNumberFormatter(), // 전화번호 형식 지정
                  ],
                ),
                buildInputField(
                  title: '주소',
                  hintText: '주소를 입력해 주세요',
                  textEditingController: localTextEditingController,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: idError.isEmpty &&
                          passwordError.isEmpty &&
                          idTextEditingController.text.isNotEmpty &&
                          passwordTextEditingController.text.isNotEmpty
                      ? () async {
                          try {
                            // 입력값 가져오기
                            await saveUserData(
                              userId: idTextEditingController.text.trim(),
                              image: "default_image_url", // 이미지 기본값
                              local: localTextEditingController.text.trim(),
                              localCode: "default_local_code", // 지역 코드 기본값
                              nickname: nameTextEditingController.text.trim(),
                              password:
                                  passwordTextEditingController.text.trim(),
                              phone: phoneTextEditingController.text.trim(),
                              petName: '',
                              petAge: 0,
                              petDogCat: '',
                              petInformation: '',
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('회원가입이 완료되었습니다!'),
                            ));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('회원가입 중 오류가 발생했습니다: $e'),
                            ));
                          }
                        }
                      : null, // 유효하지 않으면 버튼 비활성화
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A52BE),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    '가입하기',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputField({
    required String title,
    required String hintText,
    required TextEditingController textEditingController,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    String? errorText,
    Widget? suffixIcon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          TextField(
            maxLines: 1,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            controller: textEditingController,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 11,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
