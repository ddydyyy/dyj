import 'package:flutter/material.dart';

// StatelessWidget : 앱 시작 시 랜더링 후 불변
// StatefulWidget : 각종 상호작용에 따라 UI 변경
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Ref Demo'),
          titleTextStyle: Theme.of(context).textTheme.headlineLarge,
        ),

        body: ListView(
          // child : div, span 같은 느낌
          children: const [
            ChartBox(
              title: '어제 사람들이 관심있던 ETF/ETN',
              subtitle: 'This is a custom card widget.',
            ),
          ],
        ),
      ),
    );
  }
}

class ChartBox extends StatelessWidget {
  // 입력 변수 title, subtitle
  final String title;
  final String subtitle;

  // TestWidget1 생성자
  // required this.title, required this.subtitle
  // -> 이 위젯 사용 시 title과 subtitle을 필수로 입력하도록 설정
  const ChartBox({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    this.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: (){ },
                    child: Text('더보기')
                  )
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}


// class RankDetail extends StatelessWidget {
//   RankDetail({required this.label, required this.icon, required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon),
//       label: Text(label),
//     );
//   }
// }