// // main.dart (또는 stock_screen.dart)
// import 'package:finance/provider/test.provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class TestScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Consumer<TestProvider>(
//         builder: (context, provider, child) {
//           // 데이터가 null이면 에러 메시지 표시
//           if (provider.stockData == null) {
//             return Text('데이터를 불러올 수 없습니다.');
//           }
//
//           // 데이터가 존재하면 주식 정보를 표시
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('종목명: ${provider.stockData!.companyName}'),
//               Text('현재가: ${provider.stockData!.price}'),
//               Text('변동: ${provider.stockData!.change}'),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }