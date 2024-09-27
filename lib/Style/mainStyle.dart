// 모든 파일에 공통으로 적용되는 스타일 작성 -> ThemeData

// flutter의 기본적인 UI 구성 요소를 가져옴
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.blue,
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 30, color: Colors.black),
        headlineLarge: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}