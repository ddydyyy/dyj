import 'package:finance/models/stock_chart_model.dart';
import 'package:finance/services/stock_chart_service.dart';
import 'package:flutter/material.dart';

class StockChartProvider with ChangeNotifier {
  final StockChartService _service = StockChartService();
  List<StockChartModel> _data = [];

  List<StockChartModel> get data => _data;

  Future<void> load5MinData(String symbol) async {
    try {
      _data = await _service.fetch5MinData(symbol);
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