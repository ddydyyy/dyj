// // stock_provider.dart
// import 'package:finance/services/StockService.dart';
// import 'package:flutter/material.dart';
//
// import '../service/kis_service.dart';
//
// class StockProvider with ChangeNotifier {
//   String? _accessToken;
//   String? get accessToken => _accessToken;
//
//   final KISService _kisService = KISService();
//
//   // StockProvider가 앱 실행하면서 생성될 때 loadAccessToken() 호출
//   StockProvider() {
//     loadAccessToken();
//   }
//
//   // 데이터를 가져와서 저장하는 메서드
//   Future<void> loadAccessToken() async {
//     print('1');
//     _accessToken = await _kisService.getApi();
//     print('2');
//     notifyListeners();  // 데이터 변경 사항 알림
//   }
// }