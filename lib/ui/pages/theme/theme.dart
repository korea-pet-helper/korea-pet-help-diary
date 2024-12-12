import 'package:flutter/material.dart';

// appBarTheme: 모든 AppBar에 기본적으로 적용될 스타일 정의
final appBarTheme = AppBarTheme(
  // color: AppBar의 배경 색상
  color: Color(0xFF2A52BE),
  // titleTextStyle: AppBar 타이틀의 텍스트 스타일
  titleTextStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
);

// inputDecoration: 모든 텍스트 필드에 기본적으로 적용될 스타일 정의
final inputDecoration = InputDecoration(
  // contentPadding: 입력 내용의 좌우 여백과 상하 여백
  contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
  // hintStyle: 힌트 텍스트의 스타일 (색상과 크기)
  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
  // border: 텍스트 필드의 테두리 스타일
  border: OutlineInputBorder(
    // borderRadius: 테두리의 모서리를 둥글게 처리
    borderRadius: BorderRadius.circular(10),
    // borderSide: 테두리의 색상과 스타일 정의
    borderSide: const BorderSide(color: Colors.grey),
  ),
);

// elevatedButtonStyle: 모든 ElevatedButton에 기본적으로 적용될 스타일 정의
final elevatedButtonStyle = ElevatedButton.styleFrom(
  // backgroundColor: 버튼의 배경 색상
  backgroundColor: Color(0xFF2A52BE),
  // foregroundColor: 버튼의 텍스트 색상
  foregroundColor: Colors.white,
  // minimumSize: 버튼의 최소 크기 (너비와 높이)
  minimumSize: Size(double.infinity, 50),
  // elevation: 버튼의 그림자 깊이
  elevation: 5,
  // shape: 버튼의 모양 (모서리를 둥글게 처리)
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);
