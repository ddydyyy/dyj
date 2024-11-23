import 'package:finance/models/StockModel.dart';
import 'package:finance/provider/StockProvider.dart';
import 'package:finance/provider/ThemeProvider.dart';
import 'package:finance/services/StockService.dart';
import 'package:finance/widgets/StockChartWidget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

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
      child: TestApp(),
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
                child: Text('Test 버튼'),
              ),
            ),
            Container(
              height: 300,
              child: FutureBuilder<List<StockMinData>>(
                future: StockService().getMinData(accessToken),
                // future에서 기다린 데이터 -> snapshot
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<StockMinData> stockData = snapshot.data!;
                    print('stockList : ${snapshot.data!}');

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
                    return GraphWidget(stockData: stockData);

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
                    return Center(child: Text('No data available'));
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
