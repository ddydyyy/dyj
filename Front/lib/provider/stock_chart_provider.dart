import 'package:finance/models/stock_chart_model.dart';
import 'package:finance/services/stock_chart_service.dart';
import 'package:flutter/material.dart';

class StockChartProvider with ChangeNotifier {
  // 데이터 저장 리스트
  List<StockChartModel> _data = [];

  final StockChartService _service = StockChartService();

  // get 함수
  List<StockChartModel> get data => _data;

  Future<void> loadData(String symbol) async {
    try {
      // 비동기로 loadData 실행
      _data = await _service.getData(symbol);
      print('test0');
      _data.map((stock) {
        // 시간 확인
        print('test : ${stock.timestamp}');
      }).toList();
      // final index = value.toInt();
      // final timestamp = stockChartProvider.data[index].timestamp;

      notifyListeners();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}

// import 'package:finance/models/stock_chart_model.dart';
// import 'package:finance/services/stock_chart_service.dart';
// import 'package:flutter/material.dart';
//
// class StockChartProvider with ChangeNotifier {
//   final StockChartService _service = StockChartService();
//   List<StockChartModel> _data = [];
//
//   List<StockChartModel> get data => _data;
//
//   Future<void> load5MinData() async {
//     try {
//       _data = await _service.fetch5MinData();
//       notifyListeners();
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }
// }