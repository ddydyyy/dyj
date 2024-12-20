import 'package:finance/provider/stock_provider.dart';
import 'package:finance/provider/theme_provider.dart';
import 'package:finance/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

void main() {
  runApp(
    // Provider 이용
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => StockProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        // import 'dart:ui'; 해야 사용 가능
        // 웹 화면 좌우 스크롤
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      title: 'Flutter Demo',   // 앱 제목
      theme: themeProvider.currentTheme.themeData,
      home: const Start(),
    );
  }
}