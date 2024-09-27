// flutter의 기본적인 UI 구성 요소를 가져옴
import 'package:flutter/material.dart';

// 실행 시 MyApp 클래스로 애플리케이션 실행
void main() {
  runApp(MyApp());
}

// StatelessWidget을 상속받아, 앱의 기본 구조를 정의
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 머티리얼 디자인을 사용하는 앱의 기본적인 설정을 제공
    return MaterialApp(
      // 앱 제목
      title: 'Hello Flutter',
      // Scaffold 위젯 사용( 레이아웃 ), Wrapper 느낌
      // 앱바( 헤더 ), 바디, BottomNavigationBar or persistentFooterButtons( footer )
      home: Scaffold(
        // 앱바( 헤더 )
        appBar: AppBar(
          // 제목
          title: Text('Flutter Demo'),
        ),

        // Center 위젯 사용( 레이아웃 )
        // const 쓰면 안바뀜 -> 최적화(다데서 갖다 써도 안바뀜)
        body: const Center(
          // child : div, span 같은 느낌
          child: Text(
            'Hello, World!',
            // css나 scss로 못빼고 위에 스타일 정의하고, 상속받을 수는 있음
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}