// models/stock_model.dart
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

class TestModel {
  final String symbol;
  final double price;
  final double change;
  final String companyName;

  TestModel({
    required this.symbol,
    required this.price,
    required this.change,
    required this.companyName,
  });

  // JSON 데이터를 StockModel로 변환
  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      symbol: json['symbol'],
      price: json['price'],
      change: json['change'],
      companyName: json['companyName'],
    );
  }
}