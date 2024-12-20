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
        const TitleText(text: '주요 지수', list: []),
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

        const SizedBox(height: 14),
        DivLine(themeProvider: themeProvider),
        const SizedBox(height: 24),
        const TitleText(
          text: '실시간 랭킹',
          list: ['한국', '미국', '암호화폐'],
        ),
        if (accessToken != null)
          SlideTab(
            accessToken: accessToken,
            num: 1,
          ),
        const SizedBox(height: 14),
        DivLine(themeProvider: themeProvider),
      ],
    );
  }
}

// 제목
class TitleText extends StatefulWidget {
  final String text;
  final List<String> list;

  const TitleText({
    super.key,
    required this.text,
    required this.list,
  });

  @override
  State<TitleText> createState() => _TitleTextState();
}

class _TitleTextState extends State<TitleText> {
  // 선택된 항목 인덱스
  int _selectedIndex = 0;

  void _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          widget.list.isNotEmpty
              ? Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300, // 회색 배경
                    borderRadius: BorderRadius.circular(20), // 둥근 모서리
                  ),
                  child: Transform.translate(
                    offset: const Offset(-2, 0),
                    child: Row(
                      children: widget.list.map((item) {
                        // 각 항목 인덱스
                        int index = widget.list.indexOf(item);

                        return TextButton(
                          onPressed: () => _onSelected(index),
                          style: TextButton.styleFrom(
                            // 최소크기 삭제
                            minimumSize: const Size(0, 0),
                            padding: item.length > 3
                                ? const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 6,
                                  )
                                : const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 6,
                                  ),
                            backgroundColor: _selectedIndex == index
                                ? Colors.white
                                : Colors.grey.shade300,
                            // 해당 영역만큼만 공간 차지하게 설정
                            tapTargetSize: MaterialTapTargetSize.padded,
                          ),
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
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
    // ThemeProvider의 상태 변화에 따라 업데이트
    // -> 라이트, 다크모드 변경 시에만 랜더링
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
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
      },
    );
  }
}
