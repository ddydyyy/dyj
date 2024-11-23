import 'package:finance/models/stock_model.dart';
import 'package:finance/provider/stock_provider.dart';
import 'package:finance/provider/theme_provider.dart';
import 'package:finance/services/stock_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  // KospiService.getKospi();
  // 타임존 데이터 초기화
  runApp(
    // Provider 이용
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => StockProvider()),
      ],
      child: const TestApp(),
      // child: TestApp(),
    ),
  );
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  // late Future<List<StockDataModel>?> stockData;
  //
  // @override
  // void initState() {
  //   stockData = StockDataService().stockData(symbol: 'AAPL');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final accessToken = Provider.of<StockProvider>(context).accessToken;

    return MaterialApp(
      title: 'Test',
      // theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Theme Demo'),
        ),
        // 응답 완료까지 대기
        body: Column(
          children: [
            // Container(
            //     height: 300,
            //     child: GraphWidget()
            // ),
            Center(
              child: TextButton(
                // accessToken 확인
                // onPressed: () => print(stockProvider.accessToken),
                onPressed: () => {
                  // StockService().getMinData(accessToken),
                  // print(''),
                  StockService().getStockData(accessToken, 005930),
                },

                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.greenAccent,
                ),
                child: const Text('Test 버튼'),
              ),
            ),
            SizedBox(
              height: 300,
              child: FutureBuilder<List<StockMinData>>(
                future: StockService().getMinData(accessToken),
                // future에서 기다린 데이터 -> snapshot
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<StockMinData> stockData = snapshot.data!;
                    debugPrint('stockList : ${snapshot.data!}');

                    // stockList의 각 StockData 객체를 Map으로 변환
                    // List<Map<String, dynamic>> stockData = stockList.map((stck) {
                    //   return stck.toMap(); // 변환
                    // }).toList();

                    // print('awefasdf : ${stockList[0].stck_cntg_hour}, aw2233df : ${stockList[0].stck_prpr}');
                    // print('aw2233df : ${stockList[0].stck_prpr}');

                    // stockList에서 데이터를 가져와서 FlSpot 리스트로 변환
                    // List<FlSpot> spots = stockList.map((stock) {
                    //   // String 값을 double로 변환
                    //   double time = double.parse(stock.stck_cntg_hour); // 시간값
                    //   double price =
                    //       double.parse(stock.stck_prpr.toString()); // 가격값
                    //
                    //   return FlSpot(time, price); // FlSpot 객체 생성
                    // }).toList();
                    // return Text(';;');
                    return Graph(stockData: stockData);

                    // return Center(child:
                    // TextButton(
                    //   // accessToken 확인
                    //   // onPressed: () => print(stockProvider.accessToken),
                    //   onPressed: () =>{
                    //     print('44444 : ${snapshot}'),
                    //   },
                    //   style: TextButton.styleFrom(
                    //     foregroundColor: Colors.black,
                    //     backgroundColor: Colors.greenAccent,
                    //   ),
                    //   child: Text('Test 버튼'),
                    // ),);

                    // return ListView.builder(
                    //   itemCount: stockList.length,
                    //   itemBuilder: (context, index) {
                    //     return ListTile(
                    //
                    //
                    //       title: Text('Time: ${stockList[index].stck_cntg_hour}'),
                    //       subtitle: Text('Price: ${stockList[index].stck_prpr}'),
                    //     );
                    //   },
                    // );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class Graph extends StatelessWidget {
  final List<StockMinData> stockData; // stockData를 리스트로 받습니다.
  late final List<FlSpot> spots;

  // 생성자에서 stockData 받아서 spots 초기화
  Graph({super.key, required this.stockData}) {
    // stockData를 이용해 FlSpot 리스트를 생성
    spots = stockData.map((data) {
      String hourStr = data.time.padLeft(6, '0'); // 예: 143500
      int hour = int.parse(hourStr.substring(0, 2)); // 14
      int minute = int.parse(hourStr.substring(2, 4)); // 35
      int second = int.parse(hourStr.substring(4, 6)); // 00
      DateTime dateTime =
      DateTime(2023, 1, 1, hour, minute, second); // 기본 날짜 설정

      double time = dateTime.millisecondsSinceEpoch.toDouble(); // x축 값 (시간)
      double price = data.price; // y축 값 (가격)
      return FlSpot(time, price); // FlSpot 객체 반환
    }).toList();
    // spots의 time과 price를 출력
    for (var spot in spots) {
      debugPrint('Time: ${spot.x}, Price: ${spot.y}');
    }
  }

  // final String stockName = '삼성전자';
  // final List<Map<String, dynamic>> stockData = [
  //   {'stck_cntg_hour': '090000', 'stck_prpr': 100.0},
  //   {'stck_cntg_hour': '100000', 'stck_prpr': 120.0},
  //   {'stck_cntg_hour': '110000', 'stck_prpr': 100.0},
  //   {'stck_cntg_hour': '120000', 'stck_prpr': 250.0},
  //   {'stck_cntg_hour': '123000', 'stck_prpr': 200.0},
  //   {'stck_cntg_hour': '130000', 'stck_prpr': 300.0},
  //   {'stck_cntg_hour': '135000', 'stck_prpr': 340.0},
  //   {'stck_cntg_hour': '140000', 'stck_prpr': 380.0},
  //   {'stck_cntg_hour': '143000', 'stck_prpr': 370.0},
  //   {'stck_cntg_hour': '150000', 'stck_prpr': 460.0},
  // ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: LineChart(
        LineChartData(
          // 배경 격자
          gridData: const FlGridData(show: false),
          // 경계선
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            // x축 타이틀
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                // 타이틀 공간
                reservedSize: 42,
                getTitlesWidget: (value, meta) {
                  // millisecondsSinceEpoch를 DateTime으로 변환
                  DateTime date =
                  DateTime.fromMillisecondsSinceEpoch(value.toInt());
                  // 날짜를 'MM-dd' 형식으로 표시
                  String formattedDate = DateFormat('MM-dd').format(date);

                  return Text(formattedDate, style: const TextStyle(fontSize: 10));
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              color: Colors.blue,
              dotData: const FlDotData(show: false),
              isStrokeCapRound: true, // 점선 스타일 설정
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class GraphWidget extends StatelessWidget {
//   final data;
//
//   const GraphWidget({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     // data가 비어있지 않은 경우 마지막 y값을 가져옵니다.
//     final double? lastYValue = data.isNotEmpty ? data.last.y : null;
//     print('last : $lastYValue');
//     // // 마지막 점에만 텍스트 표시
//     // List<Widget> textWidgets = [
//     //   if (data.isNotEmpty) // spots가 비어있지 않으면
//     //     Positioned(
//     //       left: data.last.x * 50,  // x 위치 조정 (비율에 맞게)
//     //       bottom: data.last.y * 10, // y 위치 조정 (비율에 맞게)
//     //       child: Text(
//     //         '${data.last}',  // 마지막 가격 표시
//     //         style: TextStyle(color: Colors.black, fontSize: 12),
//     //       ),
//     //     ),
//     // ];
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: LineChart(
//         LineChartData(
//           // 배경 격자
//           gridData: FlGridData(show: false),
//           // 경계선
//           borderData: FlBorderData(show: false),
//           // 마지막 데이터의 가격만 표시
//           lineBarsData: [
//             LineChartBarData(
//               spots: data,
//               // spots: [
//               //   FlSpot(0, 1),
//               //   FlSpot(1, 2),
//               //   FlSpot(2, 1.5),
//               //   FlSpot(3, 3),
//               //   FlSpot(4, 2),
//               //   FlSpot(5, 4),
//               // ],
//               isCurved: false,
//               color: Colors.blue,
//               dotData: FlDotData(show: false),
//               isStrokeCapRound: true, // 점선 스타일 설정
//             ),
//           ],
//           // lineTouchData: LineTouchData(
//           //   enabled: true,
//           //   touchTooltipData: LineTouchTooltipData(
//           //     // tooltipBgColor: Colors.black.withOpacity(0.8),
//           //     tooltipRoundedRadius: 8,
//           //     getTooltipItems: (touchedSpots) {
//           //       // 마지막 포인트에만 텍스트 표시
//           //       if (touchedSpots.isNotEmpty) {
//           //         final lastSpot = touchedSpots.last;
//           //         if (lastSpot.x == 5) { // 마지막 포인트의 x 좌표 체크
//           //           return [
//           //             LineTooltipItem(
//           //               lastSpot.y.toStringAsFixed(2),
//           //               TextStyle(
//           //                 color: Colors.white,
//           //                 fontWeight: FontWeight.bold,
//           //               ),
//           //             ),
//           //           ];
//           //         }
//           //       }
//           //       return [];
//           //     },
//           //   ),
//           // ),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//                 interval: 3,
//
//                 // 제목과 차트 사이 공간
//                 reservedSize: 50,
//               ),
//               // axisNameWidget: Text('Y Axis'),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   // X축 값에 대한 시간 포맷 적용
//                   String time = formatTime(value.toInt());
//                   return Text(time,
//                       style: TextStyle(fontSize: 10)); // '10:00' 형식으로 리턴
//                 },
//               ),
//             ),
//             rightTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 40,
//                 getTitlesWidget: (value, meta) {
//                   // 변경된 부분: 마지막 값과 근접한 경우에도 표시
//                   if (lastYValue != null && (value - lastYValue).abs() < 1000) {
//                     return Text(
//                       lastYValue.toString(),
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     );
//                   }
//                   return Container();
//                 },
//               ),
//             ),
//             topTitles: AxisTitles(
//               // axisNameWidget: Text('Top Axis'),
//               sideTitles: SideTitles(showTitles: false), // 위 X축 라벨 표시 안 함
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// String formatTime(int time) {
//   // '100000'을 DateTime으로 변환하기 위해 문자열로 처리 후 DateFormat 사용
//   String timeString = time.toString().padLeft(6, '0'); // 100000 -> '100000'
//   DateTime dateTime = DateTime.parse('2024-01-01 $timeString');
//   return DateFormat('HH:mm').format(dateTime); // '10:00' 형식으로 변환
// }

// String formatTime(int time) {
//   String timeString = time.toString().padLeft(6, '0');
//   DateTime dateTime = DateTime.parse('2024-01-01 $timeString');
//   return DateFormat('HH:mm').format(dateTime);
// }


