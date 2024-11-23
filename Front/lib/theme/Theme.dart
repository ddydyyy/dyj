// theme/Theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static Color amber800 = const Color.fromARGB(255, 255, 111, 0);

  final Color backgroundColor;
  final Color primaryColor;
  final Color textColor;
  final Color bottomNavBackgroundColor;
  final Color bottomNavSelectedItemColor;
  final Color bottomNavUnselectedItemColor;

  // 텍스트 스타일
  final TextStyle bodyLargeStyle;
  final TextStyle bodyMediumStyle;
  final TextStyle bodySmallStyle;

  AppTheme({
    required this.backgroundColor,
    required this.primaryColor,
    required this.textColor,
    required this.bottomNavBackgroundColor,
    required this.bottomNavSelectedItemColor,
    required this.bottomNavUnselectedItemColor,
    required this.bodyLargeStyle,
    required this.bodyMediumStyle,
    required this.bodySmallStyle,
  });

  // 라이트 모드 스타일
  static final lightTheme = AppTheme(
    backgroundColor: Colors.white,
    primaryColor: Colors.blue,
    textColor: Colors.black,
    bottomNavBackgroundColor: Colors.white,
    bottomNavSelectedItemColor: Colors.blue,
    bottomNavUnselectedItemColor: Colors.black45,

    bodyLargeStyle: const TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    bodyMediumStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    bodySmallStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
  );

  // 다크 모드 스타일
  static final darkTheme = AppTheme(
    backgroundColor: Colors.black,
    primaryColor: Colors.blueGrey,
    textColor: Colors.white,
    bottomNavBackgroundColor: Colors.black,
    bottomNavSelectedItemColor: amber800,
    bottomNavUnselectedItemColor: Colors.white60,

    bodyLargeStyle: const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    bodyMediumStyle: const TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodySmallStyle: const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
  );



  // 앱에 적용할 테마 반환
  ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      // 배경색
      primaryColor: primaryColor,
      // primary 색상
      textTheme: TextTheme(
        // 제목 등
        bodyLarge: bodyLargeStyle,
        // 일반 텍스트나 설명 등
        bodyMedium: bodyMediumStyle,
        // 작은 알림 메시지 등
        bodySmall: bodySmallStyle,// bodySmall 사용
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
      ),
      iconTheme: IconThemeData(
        color: textColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bottomNavBackgroundColor,
        selectedItemColor: bottomNavSelectedItemColor,
        unselectedItemColor: bottomNavUnselectedItemColor,
      ),
    );
  }
}
