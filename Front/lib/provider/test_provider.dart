// stock_provider.dart
import 'package:finance/services/test_service.dart';
import 'package:flutter/material.dart';

class StockProvider with ChangeNotifier {
  String? _accessToken;
  String? get accessToken => _accessToken;

  final StockService _kisService = StockService();

  // StockProvider가 앱 실행하면서 생성될 때 loadAccessToken() 호출
  StockProvider() {
    // print('0');
    loadAccessToken();
  }

  // 데이터를 가져와서 저장하는 메서드
  Future<void> loadAccessToken() async {
    // print('1');
    _accessToken = await _kisService.getToken();
    // print('2');
    notifyListeners();  // 데이터 변경 사항 알림
  }
}