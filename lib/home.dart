// flutter의 기본적인 UI 구성 요소를 가져옴
import 'package:flutter/material.dart';

// StatelessWidget을 상속받아, 앱의 기본 구조를 정의
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 머티리얼 디자인을 사용하는 앱의 기본적인 설정을 제공
    return MaterialApp(
      // 앱 제목
      title: 'Ref Flutter',
      // Scaffold 위젯 사용( 레이아웃 ), Wrapper 느낌
      // 앱바( 헤더 ), 바디, BottomNavigationBar or persistentFooterButtons( footer )
      home: Scaffold(
        // 앱바( 헤더 )
        appBar: AppBar(
          // 제목
          title: Text('Ref Demo'),
          titleTextStyle: Theme.of(context).textTheme.headlineLarge,
        ),

        // Center 위젯 사용( 레이아웃, 중앙정렬 )
        // const 쓰면 안바뀜 -> 최적화(다데서 갖다 써도 안바뀜)
        // const -> Theme.of(context) 호출을 허용하지 않습니다.( 최대한 값을 유지하기 위해 참조를 최대한 못하게 막아둠 )
        body: Center(
          // child : div, span 같은 느낌
          child: Text(
            'Hello, World!',
            // Style/mainStyle.dart에서 정의한 bodyLarge 스타일 적용
            style: Theme.of(context).textTheme.bodyLarge,
            // style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}