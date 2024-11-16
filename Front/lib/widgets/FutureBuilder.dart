// import 'package:flutter/material.dart';
//
// class FutureBuilder extends StatelessWidget {
//   const FutureBuilder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container
//       (
//       height: 300,
//       child: FutureBuilder<List<StockData>>(
//         future: StockService().getStockData(accessToken),
// // future에서 기다린 데이터 -> snapshot
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             List<StockData> stockData = snapshot.data!;
//             print('stockList : ${snapshot.data!}');
//
//             return GraphWidget(stockData: stockData);
//
//           } else {
//             return Center(child: Text('No data available'));
//           }
//         },
//       )
//       ,
//     )
//     ,
//   }
// }
//
