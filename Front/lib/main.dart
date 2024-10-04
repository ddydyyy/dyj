// flutter의 기본적인 UI 구성 요소를 가져옴
import 'package:flutter/material.dart';
import 'Style/mainStyle.dart' as main_style;
import 'Page/home.dart';

// 실행 시 MyApp 클래스로 애플리케이션 실행.
void main() {
  runApp(
    // MaterialApp : 테마 등 여러 속성을 같이 시작해주는듯?
      MaterialApp(
        // Style/mainStyle.dart의 테마 상속받음
          theme: main_style.AppTheme.theme,
          home : Home()
      )
  );
}
