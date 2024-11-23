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

class StockMinData {
  final String stck_cntg_hour; // 시간
  final double stck_prpr; // 현재가

  StockMinData({
    required this.stck_cntg_hour,
    required this.stck_prpr,
  });

  // JSON 데이터를 StockModel로 변환
  factory StockMinData.fromJson(Map<String, dynamic> json) {
    return StockMinData(
      stck_cntg_hour: json['stck_cntg_hour'],
      stck_prpr: double.parse(json['stck_prpr']),
    );
  }
}


class CurrentStockPrice {
  // final String stockName; // 종목명
  // final String stockCode; // 종목코드
  final double currentPrice; // 현재가
  final double changePrice; // 전일 대비 가격
  final double changeRate; // 전일 대비 비율
  final int volume; // 거래량

  CurrentStockPrice({
    // required this.stockName,
    // required this.stockCode,
    required this.currentPrice,
    required this.changePrice,
    required this.changeRate,
    required this.volume,
  });

  // JSON 데이터를 객체로 변환
  factory CurrentStockPrice.fromJson(Map<String, dynamic> json) {
    return CurrentStockPrice(
      // stockName: json['stockName'] ?? 'Unknown', // 종목명
      // stockCode: json['stockCode'] ?? '', // 종목코드
      currentPrice: double.tryParse(json['stck_prpr'].toString()) ?? 0.0, // 현재가
      changePrice: double.tryParse(json['prdy_vrss'].toString()) ?? 0.0, // 등락률
      changeRate: double.tryParse(json['prdy_ctrt'].toString()) ?? 0.0, // 등락폭
      volume: int.tryParse(json['acml_vol'].toString()) ?? 0, // 거래량
    );
  }

  // 객체를 JSON으로 변환 (필요시 사용)
  // Map<String, dynamic> toJson() {
  //   return {
  //     'stockName': stockName,
  //     'stockCode': stockCode,
  //     'currentPrice': currentPrice,
  //     'changeRate': changeRate,
  //     'changeAmount': changeAmount,
  //     'volume': volume,
  //   };
  // }
}
