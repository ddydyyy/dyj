import 'package:finance/models/test_model.dart';
import 'package:finance/provider/theme_provider.dart';
import 'package:finance/services/test_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  // KospiService.getKospi();
  // 타임존 데이터 초기화
  tz.initializeTimeZones();
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
  // late Future<List<StockDataModel>?> stockData;
  //
  // @override
  // void initState() {
  //   stockData = StockDataService().stockData(symbol: 'AAPL');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      // theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Theme Demo'),
        ),
        // 응답 완료까지 대기
        body: Center(
          child: TextButton(
            // accessToken 확인
            // onPressed: () => print(stockProvider.accessToken),
            onPressed: () => {
              print('a')
            },

            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.greenAccent,
            ),
            child: Text('Test 버튼'),
          ),
        ),),
    );
  }
}
