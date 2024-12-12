import 'package:flutter/material.dart';

// 전체 테마를 정의하는 ThemeData 인스턴스 생성
final ThemeData appTheme = ThemeData(
  // 기본 색상을 설정 (여기서는 파란색 계열을 사용)
  primarySwatch: Colors.blue,

  // 앱바(AppBar) 테마 설정
  appBarTheme: AppBarTheme(
    color: Colors.blue, // 앱바 배경색 설정
    titleTextStyle: TextStyle(
      color: Colors.white, // 앱바 제목 텍스트 색상 설정
      fontSize: 20, // 앱바 제목 텍스트 크기 설정
      fontWeight: FontWeight.bold, // 앱바 제목 텍스트 굵기 설정
    ),
  ),

  // 텍스트 테마 설정
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black, // 기본 텍스트 색상 설정
      fontSize: 16, // 기본 텍스트 크기 설정
    ),
    bodyMedium: TextStyle(
      color: Colors.black, // 기본 텍스트 색상 설정
      fontSize: 14, // 기본 텍스트 크기 설정
    ),
  ),

  // 입력 필드(InputDecoration) 테마 설정
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(), // 기본 테두리 스타일 설정
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue), // 포커스 상태일 때 테두리 색상 설정
    ),
    labelStyle: TextStyle(
      color: Colors.blue, // 레이블 텍스트 색상 설정
    ),
  ),

  // 기본 버튼 스타일 테마 설정
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // 기본 버튼 배경색 설정
      foregroundColor: Colors.white, // 기본 버튼 텍스트 색상 설정
      textStyle: TextStyle(
        fontSize: 16, // 기본 버튼 텍스트 크기 설정
        fontWeight: FontWeight.bold, // 기본 버튼 텍스트 굵기 설정
      ),
      minimumSize: Size(600, 60), // 버튼의 최소 크기 설정
      padding: EdgeInsets.symmetric(horizontal: 20), // 버튼 내 패딩 설정
    ),
  ),
);
