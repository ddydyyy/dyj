// models/stock_model.dart

// api 토큰 발급
class GetApiModel {
  final String accessToken; // api 토큰
  // final String token_type; // 토큰 유형
  // final double expires_in; // 유효기간( 초 ex) 7776000 )
  // final String acess_token_token_expired; // 유효기간( ex) 2022-08-30 08:10:10 )

  GetApiModel({
    required this.accessToken,
    // required this.token_type,
    // required this.expires_in,
    // required this.acess_token_token_expired,
  });

  // JSON 데이터를 StockModel로 변환
  factory GetApiModel.fromJson(Map<String, dynamic> json) {
    return GetApiModel(
      accessToken: json['access_token'],
      // token_type: json['token_type'],
      // expires_in: json['expires_in'],
      // acess_token_token_expired: json['acess_token_token_expired'],
    );
  }
}

// 주식당일분봉조회 -> 개별주식
class StockMinData {
  final String time; // 시간
  final double price; // 현재가

  StockMinData({
    required this.time,
    required this.price,
  });

  // JSON 데이터를 StockModel 객체로 변환
  factory StockMinData.fromJson(Map<String, dynamic> json) {
    return StockMinData(
      time: json['stck_cntg_hour'],
      price: double.parse(json['stck_prpr']),
    );
  }
}

// 국장 개별 종목 데이터
class StockDataModel {
  final int price; // 현재가
  final double changePrice; // 전일 대비 가격
  final double changeRate; // 전일 대비 비율
  final int volume; // 거래량

  StockDataModel({
    required this.price,
    required this.changePrice,
    required this.changeRate,
    required this.volume,
  });

  // JSON 데이터를 객체로 변환
  factory StockDataModel.fromJson(Map<String, dynamic> json) {
    return StockDataModel(
      price: int.tryParse(json['stck_prpr'].toString()) ?? 0,
      changePrice: double.tryParse(json['prdy_vrss'].toString()) ?? 0.0,
      changeRate: double.tryParse(json['prdy_ctrt'].toString()) ?? 0.0,
      volume: int.tryParse(json['acml_vol'].toString()) ?? 0,
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

// 국내업종 현재지수 -> Kospi Kosdaq 등
class MajorIndexModel {
  final double price; // 현재가
  final double changePrice; // 전일 대비 가격
  final double changeRate; // 전일 대비 비율
  final int volume; // 거래량

  MajorIndexModel({
    required this.price,
    required this.changePrice,
    required this.changeRate,
    required this.volume,
  });

  // JSON 데이터를 객체로 변환
  factory MajorIndexModel.fromJson(Map<String, dynamic> json) {
    return MajorIndexModel(
      price: double.tryParse(json['bstp_nmix_prpr'].toString()) ?? 0.0,
      changePrice: double.tryParse(json['bstp_nmix_prdy_vrss'].toString()) ?? 0.0,
      changeRate: double.tryParse(json['bstp_nmix_prdy_ctrt'].toString()) ?? 0.0,
      volume: int.tryParse(json['acml_vol'].toString()) ?? 0,
    );
  }
}



