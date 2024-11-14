import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';  // NTP 패키지 사용

class StockDataModel {
  final String time;
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
  static Future<StockDataModel> fromJson(String time, Map<String, dynamic> json) async {
    // UTC 시간 파싱
    final dateTimeUtc = DateTime.parse(time).toUtc();

    // NTP를 사용하여 미국 동부 시간으로 변환
    final newYorkTime = await formatToNewYorkTime(dateTimeUtc);

    return StockDataModel(
      time: newYorkTime,
      open: double.parse(json['1. open']),
      high: double.parse(json['2. high']),
      low: double.parse(json['3. low']),
      close: double.parse(json['4. close']),
      volume: int.parse(json['5. volume']),
    );
  }

  // NTP를 사용하여 미국 동부 시간대로 변환
  static Future<String> formatToNewYorkTime(DateTime dateTimeUtc) async {
    // NTP로 현재 시간을 가져옴
    DateTime ntpTime = await NTP.now();

    // 미국 동부 시간대 변환 (예시로 -5시간 차이로 변환)
    DateTime newYorkTime = ntpTime.toUtc().add(Duration(hours: -5));

    // 날짜 포맷
    final nyFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return nyFormat.format(newYorkTime);
  }
}