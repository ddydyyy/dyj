import 'package:flutter/material.dart';

class AppTheme {
  final Color backgroundColor;
  final Color primaryColor;
  final Color textColor;
  final Color bottomNavBackgroundColor;
  final Color bottomNavSelectedItemColor;
  final Color bottomNavUnselectedItemColor;

  AppTheme({
    required this.backgroundColor,
    required this.primaryColor,
    required this.textColor,
    required this.bottomNavBackgroundColor,
    required this.bottomNavSelectedItemColor,
    required this.bottomNavUnselectedItemColor,
  });

  // 라이트 모드 스타일
  static final lightTheme = AppTheme(
    backgroundColor: Colors.white,
    primaryColor: Colors.blue,
    textColor: Colors.black,
    bottomNavBackgroundColor: Colors.white,
    bottomNavSelectedItemColor: Colors.blue,
    bottomNavUnselectedItemColor: Colors.black45,
  );

  // 다크 모드 스타일
  static final darkTheme = AppTheme(
    backgroundColor: Colors.black,
    primaryColor: Colors.blueGrey,
    textColor: Colors.white,
    bottomNavBackgroundColor: Colors.black,
    bottomNavSelectedItemColor: Colors.blue,
    bottomNavUnselectedItemColor: Colors.white60,
  );

  // 앱에 적용할 테마 반환
  ThemeData get themeData {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor, // 배경색
      primaryColor: primaryColor, // primary 색상
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),  // 변경된 bodyLarge 사용
        bodyMedium: TextStyle(color: textColor), // bodyMedium 사용
        bodySmall: TextStyle(color: textColor),  // bodySmall 사용
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