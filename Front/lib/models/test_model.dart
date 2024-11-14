import 'package:finance/library/TimeZoneConvert.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';  // NTP 패키지 사용
// import 'package:timezone/browser.dart' as tz;

class StockDataModel {
  // String이지만, timeConverter로 DateTime으로 변환
  final DateTime time;
  // final String time;
  final double open; // 시가
  final double high; // 고가
  final double low; // 저가
  final double close; // 종가
  final int volume; // 거래량

  // 생성자
  StockDataModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  // JSON을 StockData 객체로 변환하는 팩토리 메서드
  factory StockDataModel.fromJson(String time, Map<String, dynamic> json) {
    // final timeConverter = TimeZoneConverter();
    // // String -> DataTime 변환
    // final seoulTime = DateTime.parse(time);

    return StockDataModel(
      // time: timeConverter.convertToUSATime(seoulTime),
      time: DateTime.parse(time),
      open: double.parse(json['1. open']),
      high: double.parse(json['2. high']),
      low: double.parse(json['3. low']),
      close: double.parse(json['4. close']),
      volume: int.parse(json['5. volume']),
    );
  }
}