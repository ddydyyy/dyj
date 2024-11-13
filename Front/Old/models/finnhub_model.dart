// lib/models/finnhub_model.dart

class StockDataModel {
  final double open;
  final double close;
  final double high;
  final double low;
  final DateTime time;
  final int volume;

  StockDataModel({
    required this.open,
    required this.high,
    required this.low,
    required this.volume,
    required this.close,
    required this.time,
  });

  // JSON 데이터를 모델로 변환하는 팩토리 생성자
  factory StockDataModel.fromJson(Map<String, dynamic> json) {
    return StockDataModel(
      open: json['o']?.toDouble() ?? 0.0,
      high: json['h']?.toDouble() ?? 0.0,
      low: json['l']?.toDouble() ?? 0.0,
      close: json['c']?.toDouble() ?? 0.0, // 종가
      time: DateTime.fromMillisecondsSinceEpoch(json['t'] * 1000), // 타임스탬프
      volume: json['v']?.toInt() ?? 0,
    );
  }
}