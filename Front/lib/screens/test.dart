// import 'package:finance/models/test_model.dart';
// import 'package:finance/provider/theme_provider.dart';
// import 'package:finance/services/test_service.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:timezone/data/latest.dart' as tz;
//
// class TestApp extends StatefulWidget {
//   const TestApp({super.key});
//
//   @override
//   State<TestApp> createState() => _TestAppState();
// }
//
// class _TestAppState extends State<TestApp> {
//   late Future<List<StockDataModel>?> stockData;
//
//   @override
//   void initState() {
//     stockData = StockDataService().stockData(symbol: 'AAPL');
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Test',
//       // theme: ThemeData.dark(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Custom Theme Demo'),
//         ),
//         // 응답 완료까지 대기
//         body: FutureBuilder<List<StockDataModel>?>(
//           future: stockData,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // 로딩 중 표시
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               // 에러 표시
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//               final stockList = snapshot.data!;
//               print('test.dart : ${stockList[0].time}');
//               print(
//                   'all data : ${stockList.map((data) => data.time).toList()}');
//
//               return Center(
//                 child: StockChartPage(stockList: stockList),
//                 // child: Text(
//                 //     // '${snapshot.data[2]} 123123'
//                 //     '${stockList.map((data) => data.time).toList()}}'),
//               );
//               // if (stockList.isEmpty) {
//               //   return const Center(child: Text('No data available'));
//               // }
//               // return StockChart(stockList: stockList);
//             } else {
//               return Center(child: Text('No data available')); // 데이터 없음
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class StockChartPage extends StatelessWidget {
//   final List<StockDataModel> stockList;
//
//   StockChartPage({required this.stockList});
//
//   @override
//   Widget build(BuildContext context) {
//     // time을 x축, close를 y축으로 변환
//     List<FlSpot> spots = stockList.map((data) {
//       // DateTime을 millisecondsSinceEpoch로 변환하여 x축 값으로 사용
//       return FlSpot(data.time.millisecondsSinceEpoch.toDouble(), data.close);
//     }).toList();
//
//     // y축의 최대값과 최소값 구하기
//     double minY = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b); // 최소값
//     double maxY = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b); // 최대값
//
//     return Padding(
//       padding: const EdgeInsets.all(30.0),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(show: true),
//           titlesData: FlTitlesData(
//             show: true,
//             topTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//               ),
//             ),
//             rightTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//               ),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   // x축에 12:00만 표시하도록 처리
//                   // value는 밀리초 단위이므로 DateTime으로 변환할 때 toInt()를 사용하여 처리
//                   DateTime time = DateTime.fromMillisecondsSinceEpoch(value.toInt());
//
//                   // '12:00'과 같은 시간을 조건으로 설정
//                   if (DateFormat('HH:mm').format(time) == '12:00') {
//                     return Text('12:00');
//                   }
//
//                   return const Text('');
//                 },
//               ),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   // y축에 최대값과 최소값만 표시
//                   if (value == minY || value == maxY) {
//                     return Text(value.toStringAsFixed(2)); // 최대값과 최소값만 표시
//                   }
//                   return const Text('');
//                 },
//               ),
//             ),
//           ),
//           borderData: FlBorderData(show: true),
//           lineBarsData: [
//             LineChartBarData(
//               spots: spots,
//               isCurved: true,
//               color: Colors.blue,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//           minY: minY,
//           // 최소값 설정
//           maxY: maxY, // 최대값 설정
//         ),
//       ),
//     );
//   }
// }
