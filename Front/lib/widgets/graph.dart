// import 'package:finance/models/kospi.dart';
// import 'package:finance/service/api_service.dart';
// import 'package:flutter/material.dart';
//
// class Graph1 extends StatefulWidget {
//   // final KospiModel kospi;
//
//   const Graph1({
//     super.key,
//     // required this.kospi
//   });
//
//   @override
//   State<Graph1> createState() => _Graph1State();
// }
//
// class _Graph1State extends State<Graph1> {
//   late Future<KospiModel> kospi;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('test'),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/stock_data_provider.dart'; // StockProvider import

class Graph1 extends StatefulWidget {
  final String symbol;

  const Graph1({
    Key? key,
    required this.symbol,
  }) : super(key: key);

  @override
  State<Graph1> createState() => _Graph1State();
}

class _Graph1State extends State<Graph1> {
  @override
  void initState() {
    super.initState();
    // 처음 한 번만 데이터를 가져오도록 함
    Future.microtask(() {
      Provider.of<StockDataProvider>(context, listen: false)
          .fetchData(widget.symbol);
    });
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockDataProvider>(context);

    // stockData가 null이면 로딩 중
    if (stockProvider.stockData == null) {
      return Center(child: CircularProgressIndicator());
    }

    final stockData = stockProvider.stockData!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Symbol: ${widget.symbol}'),
        Text('Open: ${stockData.open}'),
        Text('High: ${stockData.high}'),
        Text('Low: ${stockData.low}'),
        Text('Volume: ${stockData.volume}'),
      ],
    );
  }
}
