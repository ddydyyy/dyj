// widgets/StockChartWidget.dart

import 'package:finance/models/StockModel.dart';
import 'package:finance/services/StockService.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockChart extends StatelessWidget {
  final String accessToken;
  final String code;

  const StockChart({
    super.key,
    required this.accessToken,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      // color: Colors.greenAccent,
      child: Column(
        children: [
          SummaryMajorIndex(
            accessToken: accessToken,
            // 코스피(0001), 코스닥(1001), 코스피200(2001) ...
            code : '0001',
          ),
          SummaryStockData(
            accessToken: accessToken,
            code : code,
          ),
          Text('3'),
          Text('4'),
        ],
      ),
    );
  }
}

// 주요지수 요약표
class SummaryMajorIndex extends StatelessWidget {
  final String accessToken;
  final String code;

  const SummaryMajorIndex({
    super.key,
    required this.accessToken,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StockService().getMajorIndex(accessToken, code),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              // 로딩 표시
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              // 에러 표시
              child: Text("Error loading data"),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return Container(
            // color: Colors.grey,
            height: 60,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('123'),
                        // Text('${data.currentPrice}'),
                        // Text('${data.changePrice}'),
                        Text('주요지수 - KOSPI'),
                        Text('${data.volume}'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('그래프'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${data.price}'),
                        // 가격 56000 -> 56,000 처럼 표시
                        // Text(
                        //   NumberFormat('#,###').format(data.price),
                        // ),
                        Text('${data.changeRate}%',
                          style: TextStyle(
                            color: data.changeRate > 0
                                ? Colors.red
                                : data.changeRate < 0
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // 데이터가 없는 경우의 기본 반환값 추가
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              child: Text("No data available"),
            ),
          );
        }
      },
    );
  }
}

// 보유종목 요약표
class SummaryStockData extends StatelessWidget {
  final String accessToken;
  final String code;

  const SummaryStockData({
    super.key,
    required this.accessToken,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StockService().getStockData(accessToken, code),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              // 로딩 표시
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              // 에러 표시
              child: Text("Error loading data"),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return Container(
            // color: Colors.grey,
            height: 60,
            child: Row(
              children: [
                Flexible(
                  flex: 3,
                  child: Container(
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('123'),
                        // Text('${data.currentPrice}'),
                        // Text('${data.changePrice}'),
                        Text('개별종목 - 삼성전자'),
                        Text('${data.volume}'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('그래프'),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text('${data.currentPrice}'),
                        // 가격 56000 -> 56,000 처럼 표시
                        Text(
                          NumberFormat('#,###').format(data.price),
                        ),
                        Text('${data.changeRate}%',
                          style: TextStyle(
                            color: data.changeRate > 0
                                ? Colors.red
                                : data.changeRate < 0
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // 데이터가 없는 경우의 기본 반환값 추가
          return Container(
            color: Colors.grey,
            height: 60,
            child: const Center(
              child: Text("No data available"),
            ),
          );
        }
      },
    );
  }
}

// class TopDownTab extends StatelessWidget {
//
//   TopDownTab({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Column(
//         children: [
//           Icon(Icons.arrow_drop_down_sharp),
//         ],
//       );
//   }
// }

class GraphWidget extends StatelessWidget {
  List<StockMinData> stockData; // stockData를 리스트로 받습니다.
  late final List<FlSpot> spots;

  // 생성자에서 stockData 받아서 spots 초기화
  GraphWidget({super.key, required this.stockData}) {
    // stockData를 이용해 FlSpot 리스트를 생성
    spots = stockData.map((data) {
      String hourStr = data.stck_cntg_hour.padLeft(6, '0'); // 예: 143500
      int hour = int.parse(hourStr.substring(0, 2)); // 14
      int minute = int.parse(hourStr.substring(2, 4)); // 35
      int second = int.parse(hourStr.substring(4, 6)); // 00
      DateTime dateTime =
          DateTime(2023, 1, 1, hour, minute, second); // 기본 날짜 설정

      double time = dateTime.millisecondsSinceEpoch.toDouble(); // x축 값 (시간)
      double price = data.stck_prpr; // y축 값 (가격)
      return FlSpot(time, price); // FlSpot 객체 반환
    }).toList();
    // spots의 time과 price를 출력
    for (var spot in spots) {
      print('Time: ${spot.x}, Price: ${spot.y}');
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
    return Container(
      height: 300,
      width: 300,
      child: LineChart(
        LineChartData(
          // 배경 격자
          gridData: FlGridData(show: false),
          // 경계선
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: AxisTitles(
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

                  return Text(formattedDate, style: TextStyle(fontSize: 10));
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: false,
              color: Colors.blue,
              dotData: FlDotData(show: false),
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