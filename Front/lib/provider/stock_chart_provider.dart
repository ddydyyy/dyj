// lib/provider/stock_chart_provider.dart

import 'package:finance/models/stock_chart_model.dart';
import 'package:finance/services/stock_chart_service.dart';
import 'package:flutter/material.dart';

class StockChartProvider with ChangeNotifier {
  final StockChartService _stockChartService = StockChartService();

  // 종가 데이터 리스트 저장 변수
  List<StockChartModel> _stockChartList = [];

  // 종가 데이터 리스트 getter
  List<StockChartModel> get stockChartList => _stockChartList;

  // 마지막 요청 시각 저장 변수
  DateTime? _lastFetchedTime;

  // 주식 데이터 fetch 메서드
  Future<void> fetchStockChartChart(String symbol) async {
    final now = DateTime.now();

    // 마지막 요청 후 5분이 지나지 않았다면 새로운 요청을 하지 않음
    if (_lastFetchedTime != null &&
        now.difference(_lastFetchedTime!).inMinutes < 5) {
      return;
    }

    // 종가 데이터 가져오기
    List<StockChartModel> fetched = await _stockChartService.getStockChart(symbol);

    // fetched가 null이 아닐 경우에만 _stockData에 값을 할당
    if (fetched.isNotEmpty) {
      _stockChartList = fetched;
    }

    // 마지막 요청 시각을 현재 시각으로 업데이트
    _lastFetchedTime = DateTime.now();

    // 데이터 업데이트 후 notifyListeners 호출
    notifyListeners();
  }
}