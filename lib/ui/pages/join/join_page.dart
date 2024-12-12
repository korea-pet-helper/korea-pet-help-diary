import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korea_pet_help_diary/util/formatter.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  String idError = ''; //최소글자수 미만일 때 사용
  String passwordError = ''; //최소글자수 미만일 때 사용

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
                ),
                buildInputField(
                  title: '비밀번호',
                  hintText: '비밀번호를 입력해 주세요',
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
                  title: '비밀번호확인', //비밀번호와 다를 시 에러메세지 줘야함.
                  hintText: '비밀번호를 다시 입력해 주세요',
                  obscureText: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
                buildInputField(
                  title: '전화번호',
                  hintText: '000-0000-0000',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능
                    PhoneNumberFormatter(), // 전화번호 형식 지정
                  ],
                ),
                buildInputField(
                  title: '주소',
                  hintText: '주소를 입력해 주세요',
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.gps_fixed),
                    onTap: () {
                      print('GPS 아이콘 클릭됨');
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  //아이디, 비번 빈값도 널체크해야함.
                  onPressed: idError.isEmpty && passwordError.isEmpty
                      ? () {
                          // 버튼 클릭 시 실행할 함수
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
                )
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
            obscureText: obscureText, // 비밀번호 여부 처리
            keyboardType: keyboardType, // 키보드 유형 처리
            inputFormatters: inputFormatters, // 입력 포맷터 적용
            onChanged: onChanged, // 입력값 변경 시 처리
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
              errorText: errorText, // 에러 메시지 표시
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              suffixIcon: suffixIcon, // suffixIcon 적용
            ),
          ),
        ],
      ),
    );
  }
}
