class StockChartModel {
  final DateTime timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  StockChartModel({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory StockChartModel.fromJson(Map<String, dynamic> json) {
    return StockChartModel(
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['t']),
      open: json['o'].toDouble(),
      high: json['h'].toDouble(),
      low: json['l'].toDouble(),
      close: json['c'].toDouble(),
      volume: json['v'].toDouble(),
    );
  }
}


// 장 종료 후 해당 일자의 데이터 제공
// class StockChartModel {
//   final String symbol; // 티커
//   final double close; // 종가
//   final double high; // 고가
//   final double low; // 저가
//   // final int num; // 집계량
//   final double open; // 시가
//   // final bool otc; // OTC 티커용인지 ??
//   // final DateTime timestamp; // 타임스탬프 ??
//   final double volume; // 거래량
//   final double vw; // 거래량 가중 평균 가격
//
//   StockChartModel({
//     required this.symbol,
//     required this.close,
//     required this.high,
//     required this.low,
//     // required this.num,
//     required this.open,
//     // required this.otc,
//     // required this.timestamp,
//     required this.volume,
//     required this.vw,
//   });
//
//   factory StockChartModel.fromJson(Map<String, dynamic> json) {
//     return StockChartModel(
//       // timestamp: DateTime.fromMillisecondsSinceEpoch(json['t']),
//       symbol: json['T'].toString(),
//       // null 체크 후 변환
//       close: (json['c'] != null) ? json['c'].toDouble() : 0.0,
//       high: (json['h'] != null) ? json['h'].toDouble() : 0.0,
//       low: (json['l'] != null) ? json['l'].toDouble() : 0.0,
//       // num: json['n'].toInt(),
//       open: (json['o'] != null) ? json['o'].toDouble() : 0.0,
//       // otc: json['otc'].toBool(),
//       volume: (json['v'] != null) ? json['v'].toDouble() : 0.0,
//       vw: (json['vw'] != null) ? json['vw'].toDouble() : 0.0,
//     );
//   }
//
//   // ref
//   // {
//   //   "T": "KIMpL",
//   //   "c": 25.9102,
//   //   "h": 26.25,
//   //   "l": 25.91,
//   //   "n": 74,
//   //   "o": 26.07,
//   //   "t": 1602705600000,
//   //   "v": 4369,
//   //   "vw": 26.0407
//   // }
// }