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
