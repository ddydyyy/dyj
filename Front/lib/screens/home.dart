import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:finance/provider/stock_provider.dart';
import 'package:finance/widgets/stock_chart_widget.dart';
import 'package:finance/widgets/slide_tab_widget.dart';
import 'package:finance/widgets/search_widget.dart';

// StatelessWidget : 앱 시작 시 랜더링 후 불변
// StatefulWidget : 각종 상호작용에 따라 UI 변경
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeProvider에서 currentTheme 가져오기
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final Future<KospiModel> kospi = KospiService.getKospi();
    final accessToken = Provider.of<StockProvider>(context).accessToken;

    return Column(
      children: [
        Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: const Column(
                children: [
                  // 검색창
                  Search(),
                  SizedBox(
                    height: 10,
                  ),
                  // accessToken != null?
                  // SlideTab(accessToken: accessToken)
                  //     : const SizedBox(),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                ],
              ),
            ),
            accessToken != null?
            SlideTab(accessToken: accessToken)
                : const SizedBox(),
            const SizedBox(
              height: 15,
            ),
            // accessToken != null
            //     ? EachStockChart(
            //         accessToken: accessToken,
            //         code: '005930',
            //       )
            //     : const SizedBox(), // 기본적으로 빈 공간을 렌더링
            // 국내, 해외, ETF 선택
          ],
        )
      ],
    );
  }
}
