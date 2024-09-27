// flutter의 기본적인 UI 구성 요소를 가져옴
import 'package:flutter/material.dart';
// import 'package:finance/Style/mainStyle.dart';
import 'Style/mainStyle.dart';

// 실행 시 MyApp 클래스로 애플리케이션 실행
void main() {
  runApp(Ref());
}

// StatelessWidget을 상속받아, 앱의 기본 구조를 정의
class Ref extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 머티리얼 디자인을 사용하는 앱의 기본적인 설정을 제공
    return MaterialApp(
      // mainStyle.dart 스타일 적용
      theme: AppTheme.theme,
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

        // Center 위젯 사용( 레이아웃, 중앙정렬 )
        // const 쓰면 안바뀜 -> 최적화(다데서 갖다 써도 안바뀜)
        // const -> Theme.of(context) 호출을 허용하지 않습니다.( 최대한 값을 유지하기 위해 참조를 최대한 못하게 막아둠 )
        body: Center(
          // child : div, span 같은 느낌
          child: Text(
            'Hello, World!',
            // css나 scss로 못빼고 위에 스타일 정의하고, 상속받을 수는 있음
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}