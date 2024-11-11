// lib/services/stock_chart_service.dart

import 'dart:convert';
import 'package:finance/models/stock_chart_model.dart';
import 'package:http/http.dart' as http;

class StockChartService {
  final String _apiKey = 'csouqu1r01qt3r34hmi0csouqu1r01qt3r34hmig'; // API 키

  // 15분 간격으로 종가 데이터를 가져오는 메서드
  Future<List<StockChartModel>> getStockChart(String symbol) async {
    // 원하는 시간 범위 설정 (예: 최근 5일)
    final url = 'https://finnhub.io/api/v1/stock/candle?symbol='
        '$symbol&resolution=60&from=1609459200&to=1609502400&'
        'token=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // 종가만 추출하여 StockModel로 변환
        List<StockChartModel> stockData = [];
        for (int i = 0; i < data['c'].length; i++) {
          stockData.add(StockChartModel.fromJson(data, i)); // i번째 데이터 사용
        }
        print('stock_chart_service - 응답 성공 : $stockData');
        return stockData;
      } else {
        print('stock_chart_service - 응답 실패 : ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('stock_chart_service - Error : $e');
      return [];
    }
  }
}

