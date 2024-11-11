// lib/services/stock_data_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_data_model.dart';

class StockDataService {
  final String _apiKey = 'csouqu1r01qt3r34hmi0csouqu1r01qt3r34hmig'; // API 키

  // 단일 주식 데이터를 가져오는 메서드
  Future<StockDataModel> getStockData(String symbol) async {
    // 주식 데이터 API URL
    final url = 'https://finnhub.io/api/v1/quote?symbol=$symbol&token=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // 단일 주식 데이터만 추출하여 StockModel로 변환
        return StockDataModel(
          open: data['o']?.toDouble() ?? 0.0,
          high: data['h']?.toDouble() ?? 0.0,
          low: data['l']?.toDouble() ?? 0.0,
          close: data['c']?.toDouble() ?? 0.0, // 종가
          time: DateTime.now(), // 현재 시간을 사용 (타임스탬프 대신)
          volume: 0, // API에서 제공되지 않으면 0으로 설정
        );
      } else {
        throw Exception('Failed to load stock data');
      }
    } catch (e) {
      print('Error fetching stock data: $e');
      throw Exception('Error fetching stock data');
    }
  }
}