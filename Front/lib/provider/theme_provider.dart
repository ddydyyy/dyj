// provider/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:finance/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    // 상태 변경을 알림
    notifyListeners();
  }

  AppTheme get currentTheme =>
      isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
}