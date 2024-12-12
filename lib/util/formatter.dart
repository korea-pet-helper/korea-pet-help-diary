import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  final int maxLength; // 최대 길이

  PhoneNumberFormatter({this.maxLength = 11}); // 생성자에서 최대 길이 설정

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 입력된 텍스트 가져오기
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), ''); // 숫자만 남기기

    // 최대 길이 제한
    if (digits.length > maxLength) {
      digits = digits.substring(0, maxLength); // 최대 길이만큼 잘라냄
    }

    // 형식 지정
    String formatted = '';
    if (digits.length >= 11) {
      formatted =
          '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7, 11)}';
    } else if (digits.length >= 7) {
      formatted =
          '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits.substring(7)}';
    } else if (digits.length >= 3) {
      formatted = '${digits.substring(0, 3)}-${digits.substring(3)}';
    } else {
      formatted = digits; // 길이가 3보다 작으면 그대로
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
