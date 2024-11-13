// import '../../Old/provider/polygon_provider.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// class LineChartWidget extends StatefulWidget {
//   final String symbol;
//
//   LineChartWidget({required this.symbol});
//
//   @override
//   State<LineChartWidget> createState() => _LineChartWidgetState();
// }
//
// class _LineChartWidgetState extends State<LineChartWidget> {
//   @override
//   Widget build(BuildContext context) {
//     // Provider를 사용하여 데이터 불러오기
//     final stockChartProvider = Provider.of<StockChartProvider>(context);
//
//     // 데이터가 없으면 로딩 표시
//     if (stockChartProvider.data.isEmpty) {
//       stockChartProvider.loadData(widget.symbol); // 데이터 로드
//       return Center(child: CircularProgressIndicator());
//     }
//
//     // 데이터가 있으면 Text로 표시
//     return SizedBox(
//       width: 300,
//       height: 300,
//       child: LineChart(
//         LineChartData(
//           borderData: FlBorderData(show: false),
//           // minX: 0, // x축의 최소값 (예: 시작 시간)
//           // maxX: 100, // x축의 최대값 (예: 하루 1440분)
//           lineBarsData: [
//             LineChartBarData(
//               spots: List.generate(stockChartProvider.data.length, (index) {
//                 final stock = stockChartProvider.data[index];
//
//                 // x축에 실제 시간 값을 넣도록 수정
//                 final timestamp = stock.timestamp;
//                 final xValue = timestamp.hour * 60 + timestamp.minute; // x축을 시간(분)으로 표현
//                 print('xValue : $xValue, yValue : ${stock.close}');
//                 // print('index : $index');
//
//                 // return FlSpot(index.toDouble(), stock.close);
//                 return FlSpot(xValue.toDouble(), stock.close); // x축은 시간 기반, y축은 close 값
//         }),
//               //   return FlSpot(
//               //       index.toDouble(), stock.close); // x축은 index, y축은 close 값
//               // }),
//               isCurved: true,
//               color: Colors.blue,
//               dotData: FlDotData(show: false),
//             ),
//           ],
//           // y축 숫자만 표시
//           titlesData: FlTitlesData(
//             show: false,
//             // leftTitles: AxisTitles(
//             //   sideTitles: SideTitles(
//             //     showTitles: true,
//             //     getTitlesWidget: (value, meta) {
//             //       // 최대값과 최소값 계산
//             //       final double maxY = stockChartProvider.data
//             //           .map((e) => e.close)
//             //           .reduce((a, b) => a > b ? a : b);
//             //       final double minY = stockChartProvider.data
//             //           .map((e) => e.close)
//             //           .reduce((a, b) => a < b ? a : b);
//             //
//             //       // value가 최대값 또는 최소값일 때만 표시
//             //       if (value == maxY || value == minY) {
//             //         return Text(value.toStringAsFixed(2),
//             //             style: TextStyle(color: Colors.black, fontSize: 10));
//             //       }
//             //       return Container(); // 그 외에는 빈 컨테이너 반환
//             //     },
//             //   ),
//             // ),
//             rightTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//               ),
//             ),
//             topTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//               ),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//                 // getTitlesWidget: (value, meta) {
//                 //   return Text(xValue);
//                 // },
//                 // getTitlesWidget: (value, meta) {
//                 //   final index = value.toInt();
//                 //   final timestamp = stockChartProvider.data[index].timestamp;
//                 //   final formattedTime = DateFormat.Hm().format(timestamp);
//                 //   // print('format : $formattedTime');
//                 //
//                 //   // timestamp에서 시간과 분을 추출
//                 //   final hour = timestamp.hour;
//                 //   final minute = timestamp.minute; // 분 추출
//                 //   // print('hour : $hour');
//                 //   // print('min : $minute');
//                 //
//                 //   // 시간과 분을 기반으로 레이블 표시
//                 //   if (hour == 12 && minute == 0) {
//                 //     // 12:00일 경우에만 x축에 표시
//                 //     return Text('${hour}:${minute.toString().padLeft(2, '0')}',
//                 //         style: TextStyle(fontSize: 10, color: Colors.black));
//                 //   } else {
//                 //     return Container(); // 12:00이 아니면 빈 컨테이너 반환
//                 //   }
//                 //   // if (index < stockChartProvider.data.length) {
//                 //   //   // timestamp에서 시간 부분 추출
//                 //   //   // final DateTime timestamp = stockChartProvider.data[index].timestamp;
//                 //   //   final formattedTime = DateFormat.Hm().format(timestamp); // 예: "09:00"
//                 //   //   if(formattedTime=='12:00'){
//                 //   //     return Text(formattedTime, style: TextStyle(fontSize: 10, color: Colors.black));
//                 //   //   } else {
//                 //   //     return Container();
//                 //   //   }
//                 //   // }
//                 //   // return Container();
//                 // },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//
//     // Text('symbol : ${widget.symbol}'),
//     // // stockChartProvider.data의 종가(close)만 출력
//     // ...stockChartProvider.data.map((stock) {
//     //   return Text('Close price: ${stock.close}');
//     // }).toList(),
//   }
// }
