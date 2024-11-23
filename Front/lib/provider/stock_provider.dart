// provider/stock_provider.dart

import 'package:finance/services/stock_service.dart';
import 'package:flutter/material.dart';

class StockProvider with ChangeNotifier {
  String? _accessToken;
  String? get accessToken => _accessToken;

  final StockService _kisService = StockService();

  // StockProvider가 앱 실행하면서 생성될 때 loadAccessToken() 호출
  StockProvider() {
    loadAccessToken();
  }

  // 데이터를 가져와서 저장하는 메서드
  Future<void> loadAccessToken() async {
    _accessToken = await _kisService.getToken();
    notifyListeners();  // 데이터 변경 사항 알림
  }
}