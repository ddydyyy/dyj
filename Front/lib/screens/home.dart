import 'package:finance/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:finance/provider/stock_provider.dart';
import 'package:finance/widgets/slide_tab_widget.dart';
import 'package:finance/widgets/search_widget.dart';

// StatelessWidget : 앱 시작 시 랜더링 후 불변
// StatefulWidget : 각종 상호작용에 따라 UI 변경
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeProvider에서 currentTheme 가져오기
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final Future<KospiModel> kospi = KospiService.getKospi();
    final accessToken = Provider.of<StockProvider>(context).accessToken;

    return Column(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Search(),
        const SizedBox(height: 20),
        const BoldText(text: '주요 지수'),
        // 슬라이드탭 + 해당 인덱스의 데이터
        if (accessToken != null)
          SlideTab(
            accessToken: accessToken,
            num: 0,
          ),
        // accessToken != null
        //     ? SlideTab(accessToken: accessToken)
        //     // 기본적으로 빈 공간을 렌더링
        //     : const SizedBox(),

        const SizedBox(height: 15),
        DivLine(themeProvider: themeProvider),
        const SizedBox(height: 15),
        const BoldText(text: '실시간 랭킹'),
        if (accessToken != null)
          SlideTab(
            accessToken: accessToken,
            num: 1,
          ),
      ],
    );
  }
}

// 제목
class BoldText extends StatelessWidget {
  final String text;

  const BoldText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.865,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// 구분선
class DivLine extends StatelessWidget {
  final ThemeProvider themeProvider;

  const DivLine({
    super.key,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      height: 7,
      color: themeProvider.isDarkMode
          ? Colors.grey.shade900
          : Colors.grey.shade200,
      // 전환 시간
      duration: const Duration(milliseconds: 100),
      // 처음, 마지막이 느리고 중간에 빨리 바뀜
      curve: Curves.easeInOut,
    );
  }
}
