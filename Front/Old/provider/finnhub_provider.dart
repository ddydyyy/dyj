// lib/provider/finnhub_provider.dart

import 'package:flutter/material.dart';
import '../models/finnhub_model.dart';
import '../service/finnhub_service.dart';

class StockDataProvider with ChangeNotifier {
  final StockDataService _stockDataService = StockDataService();

  // 주식 데이터 저장 변수 (단일 StockModel)
  StockDataModel? _stockData;

  // 마지막 요청 시각 저장 변수
  DateTime? _lastFetchedTime;

  // 주식 데이터 getter
  StockDataModel? get stockData => _stockData;

  // 주식 데이터 fetch 메서드
  Future<void> fetchData(String symbol) async {
    final now = DateTime.now();

    // 마지막 요청 후 5분이 지나지 않았다면 새로운 요청을 하지 않음
    if (_lastFetchedTime != null &&
        now.difference(_lastFetchedTime!).inMinutes < 5) {
      return;
    }

    // 주식 데이터 가져오기
    StockDataModel? fetched = await _stockDataService.getData(symbol);

    // fetchedData가 null이 아닐 경우에만 _stockData에 값을 할당
    if (fetched != null) {
      _stockData = fetched;
    }

    // 마지막 요청 시각을 현재 시각으로 업데이트
    _lastFetchedTime = DateTime.now();

    // 데이터 업데이트 후 notifyListeners 호출
    notifyListeners();
  }
}