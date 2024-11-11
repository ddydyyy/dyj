import 'package:finance/models/kospi.dart';
import 'package:finance/provider/theme_provider.dart';
import 'package:finance/service/api_service.dart';
import 'package:finance/widgets/graph.dart';
import 'package:finance/widgets/graph_tab.dart';
import 'package:finance/widgets/search.dart';
import 'package:finance/widgets/stock_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// StatelessWidget : 앱 시작 시 랜더링 후 불변
// StatefulWidget : 각종 상호작용에 따라 UI 변경
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeProvider에서 currentTheme 가져오기
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final Future<KospiModel> kospi = KospiService.getKospi();

    return Container(
      child: Column(
        children: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 검색창
              const Search(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  // vertical: 50,
                ),
                child: Column(
                  children: [
                    const GraphRow(),
                    const SizedBox(
                      height: 150,
                    ),
                    Graph1(),
                    const SizedBox(
                      height: 150,
                    ),
                    StockSummary(),
                  ],
                ),
              ),
              // 국내, 해외, ETF 선택
            ],
          )
        ],
      ),
    );

    // body: SingleChildScrollView(
    //   child: Padding(
    //     // 페이지 전체에 적용할 패딩
    //     padding: const EdgeInsets.only(
    //       left: 100,
    //       right: 100,
    //       top: 50,
    //     ),
    //     child: Column(
    //       children: [
    //
    //         Column(
    //           // crossAxisAlignment: CrossAxisAlignment.end,
    //           children: [
    //             // Column_1
    //             // 검색창
    //             Column(
    //               children: [
    //                 // 아이콘 + 검색창
    //                 const Row(
    //                   children: [
    //                     // 아이콘
    //                     Icon(Icons.insert_emoticon),
    //                     Padding(
    //                         padding: EdgeInsets.only(
    //                           left: 10,
    //                         ),
    //                     ),
    //                     Expanded(
    //                       // TextField는 크기가 정해져 있지 않음
    //                       // 왜인지 모르지만, 차지하는 공간이 계속 변하면서
    //                       // 무한로딩되는 오류가 생기는듯
    //                       // Expanded로 부모 위젯의 남은 공간을 모두 차지하게 해
    //                       // 공간을 재할당하지 않게 해서 무한로딩 방지하는듯?
    //                       child: TextField(
    //                         decoration: InputDecoration(
    //                           hintText: '주식, 메뉴, 상품, 뉴스를 검색하세요',
    //                           border: InputBorder.none, // 밑줄 제거
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 // 검색창 아래 밑줄
    //                 Container(
    //                   height: 2, // 밑줄의 두께
    //                   color: Colors.grey, // 밑줄 색상
    //                 ),
    //               ],
    //             ),
    //
    //
    //
    //
    //
    //
    //             Text(
    //               'Hey, Selena',
    //               style: TextStyle(
    //                 color: darkMode? Colors.white : Colors.black,
    //                 fontSize: 28,
    //                 fontWeight: FontWeight.w800,
    //               ),
    //             ),
    //             const Text(
    //               'Welcome back',
    //               style: TextStyle(
    //                 color: Color.fromRGBO(255, 255, 255, 0.8),
    //                 fontSize: 18,
    //               ),
    //             ),
    //           ],
    //         )
    //       ],
    //
    //     ),
    //   ),
    // ),

    // bottomNavigationBar:BottomNavigationBar(
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home_filled),
    //       label: 'home',
    //     ),
    //   ],
    // ),

    //   ),
    // );

    // return MaterialApp(
    //   title: 'Home',
    //   home: Scaffold(
    //     body: ListView(
    //       // child : div, span 같은 느낌
    //       children: [
    //         SearchBox(
    //
    //         ),
    //         const ChartBox(
    //           title: '어제 사람들이 관심있던 ETF/ETN',
    //           subtitle: 'This is a custom card widget.',
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class ChartBox extends StatelessWidget {
  // 입력 변수 title, subtitle
  final String title;
  final String subtitle;

  // TestWidget1 생성자
  // required this.title, required this.subtitle
  // -> 이 위젯 사용 시 title과 subtitle을 필수로 입력하도록 설정
  const ChartBox({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Column(
            children: [
              // 첫 번째 행
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        '더보기 >',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),

          // 두 번째 행

          // 세 번째 행
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
