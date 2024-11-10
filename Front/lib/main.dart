// 시작 파일

// flutter의 기본적인 UI 구성 요소를 가져옴
import 'package:finance/provider/provider.dart';
import 'package:finance/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Style/mainStyle.dart' as main_style;

// 실행 시 상속받은 main_style을 이용해 Home.dart 실행 -> Page/home에 있음
void main() {
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => ThemeProvider(),
  //     child: Start(),
  //   ),
  // );
  runApp(
    // Provider 이용
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const Start(),
    ),
  );
  // runApp(
  //   // MaterialApp : 테마 등 여러 속성을 같이 시작해주는듯?
  //   MaterialApp(
  //     // Style/mainStyle.dart 테마 지정
  //     theme: main_style.AppTheme.theme,
  //     home : const Start(),
  //   ),
  // );
}
