import 'package:finance/services/test_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/test.provider.dart';

void main() {
  // KospiService.getKospi();
  runApp(
    // Provider 이용
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StockProvider()),
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
  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context);
    final accessToken = stockProvider.accessToken;
    return MaterialApp(
      title: 'Test',
      // theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Theme Demo'),
        ),
        body: Center(
          child: TextButton(
            // accessToken 확인
            // onPressed: () => print(stockProvider.accessToken),
            onPressed: () => print(KISService().getStockData(accessToken, '')),

            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.greenAccent,
            ),
            child: Text('Test 버튼'),
          ),
        ),
      ),
    );
  }
}
