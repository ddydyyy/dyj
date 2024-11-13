import 'package:finance/models/test_model.dart';
import 'package:finance/provider/theme_provider.dart';
import 'package:finance/services/test_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // KospiService.getKospi();
  runApp(
    // Provider 이용
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider())
        // ChangeNotifierProvider(create: (_) => StockProvider()),
      ],
      child: TestApp(),
    ),
  );
}

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  late Future<List<StockDataModel>?> stockData;
  @override
  void initState() {
    stockData = StockDataService().stockData(symbol: 'AAPL');
    super.initState();
  }

  // 자정 이후 데이터만 선택
  List<StockDataModel> filterAfterMidnight(List<StockDataModel> stockList) {
    final midnight = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
    );

    return stockList.where((stock) {
      // 시간을 가져옴 ( String : 2024-11-12 19:00:00 )
      // String -> DataTime
      final stockTime = DateTime.parse(stock.time);
      print('Parsed time: ${stockTime}');
      // 00시 이후의 데이터만 남김
      return stockTime.isAfter(midnight);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // StockDataService().stockData(symbol: 'AAPL');
    // final stockProvider = Provider.of<StockProvider>(context);
    // final accessToken = stockProvider.accessToken;
    return MaterialApp(
      title: 'Test',
      // theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Theme Demo'),
        ),
        // 응답 완료까지 대기
        body: FutureBuilder<List<StockDataModel>?>(
          future: stockData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 로딩 중 표시
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // 에러 표시
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              // { time : 2024-11-12 19:45:00 open : 123, high : 456, ... }
              // [0]이 가장 최신
              final stockList = snapshot.data!;
              print('test : ${stockList[3].time}');
              // print(stockList[0].time);
              final aa = filterAfterMidnight(snapshot.data!);
              print('aa : $aa');
              print('123');

              // stockList.map((stock){
              //   print('123123');
              //   print('time : ${stock.time}');
              // });
              return Center(child: Text(
                // '${snapshot.data[2]} 123123'
                '${aa}'
              ));
              // if (stockList.isEmpty) {
              //   return const Center(child: Text('No data available'));
              // }
              // return StockChart(stockList: stockList);
            } else {
              return Center(child: Text('No data available')); // 데이터 없음
            }
          },
        ),
      ),
    );
  }
}

class StockChart extends StatelessWidget {
  final stockList;

  const StockChart({
    required this.stockList,
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: stockList
                .map((stock) => FlSpot(
              stock.time.hour + stock.time.minute / 60, // 시간 기반
              stock.close,
            ))
                .toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
            belowBarData: BarAreaData(show: true, color:
              Colors.blue.withOpacity(0.3),
            ),
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
            ),
          ),
        ),
      ),
    );
  }
}
// child: Center(
//   child: TextButton(
//     // accessToken 확인
//     // onPressed: () => print(stockProvider.accessToken),
//     onPressed: () => {
//       print(stockData.);
//     },
//
//     style: TextButton.styleFrom(
//       foregroundColor: Colors.black,
//       backgroundColor: Colors.greenAccent,
//     ),
//     child: Text('Test 버튼'),
//   ),
// ),
//     ),
//   ),
// );
//   }
// }
