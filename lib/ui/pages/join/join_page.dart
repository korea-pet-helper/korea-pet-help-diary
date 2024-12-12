import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
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
          // 스크롤 가능하게 수정
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // 반복되는 입력 필드를 함수로 호출
                buildInputField(
                  title: '아이디',
                  hintText: '아이디를 입력해 주세요',
                ),
                buildInputField(
                  title: '이름',
                  hintText: '이름을 입력해 주세요',
                ),
                buildInputField(
                  title: '비밀번호',
                  hintText: '비밀번호를 입력해 주세요',
                  obscureText: true, // 비밀번호는 텍스트 숨기기
                ),
                buildInputField(
                  title: '비밀번호확인',
                  hintText: '비밀번호를 다시 입력해 주세요',
                  obscureText: true,
                ),
                buildInputField(
                  title: '전화번호',
                  hintText: '전화번호를 입력해 주세요',
                  keyboardType: TextInputType.phone, // 전화번호 키보드 사용
                ),
                buildInputField(
                  title: '주소',
                  hintText: '주소를 입력해 주세요',
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 버튼 클릭 시 실행할 함수
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A52BE), // 버튼 배경 색상
                    foregroundColor: Colors.white, // 버튼 텍스트 색상
                    minimumSize: Size(double.infinity, 50), // 버튼 크기 (가로, 세로)

                    elevation: 5, // 버튼 그림자 깊이
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글게
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
    bool obscureText = false, // 텍스트 숨김 여부 기본값 false
    TextInputType keyboardType = TextInputType.text, // 키보드 유형 기본값 텍스트
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
