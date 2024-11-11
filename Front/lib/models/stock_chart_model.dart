// lib/models/stock_chart_model.dart

class StockChartModel {
  final double close; // 종가
  final DateTime time; // 시간

  StockChartModel({
    required this.close,
    required this.time,
  });

  // JSON 데이터를 StockModel로 변환하는 팩토리 생성자
  factory StockChartModel.fromJson(Map<String, dynamic> json, int i) {
    return StockChartModel(
      close: json['c'][i]?.toDouble() ?? 0.0, // 종가
      time: DateTime.fromMillisecondsSinceEpoch(json['t'][i] * 1000), // 타임스탬프
    );
  }
}