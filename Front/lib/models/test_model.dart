// models/stock_model.dart
import 'dart:ffi';

class GetApiModel {
  final String access_token; // api 토큰
  // final String token_type; // 토큰 유형
  // final double expires_in; // 유효기간( 초 ex) 7776000 )
  // final String acess_token_token_expired; // 유효기간( ex) 2022-08-30 08:10:10 )

  GetApiModel({
    required this.access_token,
    // required this.token_type,
    // required this.expires_in,
    // required this.acess_token_token_expired,
  });

  // JSON 데이터를 StockModel로 변환
  factory GetApiModel.fromJson(Map<String, dynamic> json) {
    return GetApiModel(
      access_token: json['access_token'],
      // token_type: json['token_type'],
      // expires_in: json['expires_in'],
      // acess_token_token_expired: json['acess_token_token_expired'],
    );
  }
}

class StockData {
  final String stck_cntg_hour; // 시간
  final double stck_prpr; // 현재가

  StockData({
    required this.stck_cntg_hour,
    required this.stck_prpr,
  });

  // JSON 데이터를 StockModel로 변환
  factory StockData.fromJson(Map<String, dynamic> json) {
    return StockData(
      stck_cntg_hour: json['stck_cntg_hour'],
      stck_prpr: double.parse(json['stck_prpr']),
    );
  }
}

Map<String, List<Map<String, dynamic>>> stockData = {
  '삼성전자': [
    {'date': '2023-01-01', 'price': 100.0},
    {'date': '2023-01-02', 'price': 120.0},
    {'date': '2023-01-03', 'price': 100.0},
    {'date': '2023-01-04', 'price': 250.0},
    {'date': '2023-01-05', 'price': 200.0},
    {'date': '2023-01-06', 'price': 300.0},
    {'date': '2023-01-07', 'price': 340.0},
    {'date': '2023-01-08', 'price': 380.0},
    {'date': '2023-01-09', 'price': 370.0},
    {'date': '2023-01-10', 'price': 460.0},
  ],
  '현대자동차': [
    {'date': '2023-01-01', 'price': 100.0},
    {'date': '2023-01-02', 'price': 220.0},
    {'date': '2023-01-03', 'price': 180.0},
    {'date': '2023-01-04', 'price': 140.0},
    {'date': '2023-01-05', 'price': 260.0},
    {'date': '2023-01-06', 'price': 420.0},
    {'date': '2023-01-07', 'price': 340.0},
    {'date': '2023-01-08', 'price': 300.0},
    {'date': '2023-01-09', 'price': 460.0},
    {'date': '2023-01-10', 'price': 420.0},
  ],
  'SK하이닉스': [
    {'date': '2023-01-01', 'price': 100.0},
    {'date': '2023-01-02', 'price': 220.0},
    {'date': '2023-01-03', 'price': 180.0},
    {'date': '2023-01-04', 'price': 220.0},
    {'date': '2023-01-05', 'price': 260.0},
    {'date': '2023-01-06', 'price': 420.0},
    {'date': '2023-01-07', 'price': 340.0},
    {'date': '2023-01-08', 'price': 240.0},
    {'date': '2023-01-09', 'price': 340.0},
    {'date': '2023-01-10', 'price': 460.0},
  ],
  'NAVER': [
    {'date': '2023-01-01', 'price': 100.0},
    {'date': '2023-01-02', 'price': 220.0},
    {'date': '2023-01-03', 'price': 340.0},
    {'date': '2023-01-04', 'price': 150.0},
    {'date': '2023-01-05', 'price': 260.0},
    {'date': '2023-01-06', 'price': 300.0},
    {'date': '2023-01-07', 'price': 340.0},
    {'date': '2023-01-08', 'price': 460.0},
    {'date': '2023-01-09', 'price': 340.0},
    {'date': '2023-01-10', 'price': 420.0},
  ],
  'LG화학': [
    {'date': '2023-01-01', 'price': 100.0},
    {'date': '2023-01-02', 'price': 140.0},
    {'date': '2023-01-03', 'price': 250.0},
    {'date': '2023-01-04', 'price': 260.0},
    {'date': '2023-01-05', 'price': 220.0},
    {'date': '2023-01-06', 'price': 300.0},
    {'date': '2023-01-07', 'price': 350.0},
    {'date': '2023-01-08', 'price': 320.0},
    {'date': '2023-01-09', 'price': 420.0},
    {'date': '2023-01-10', 'price': 460.0},
  ],
};
