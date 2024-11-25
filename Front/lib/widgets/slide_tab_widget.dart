// widgets/SlideWidget.dart

import 'package:finance/provider/theme_provider.dart';
import 'package:finance/widgets/stock_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// SlideTab(accessToken) : 슬라이드 탭

// EachTab(title, index, selectedIndex, onSelected)
// - 선택된 탭, 선택됐을 때 해당 탭의 Index를 전달하는 selectedIndex,
// - 선택됐을 때 실행할 함수 onSelected

// SelectedIndexData(accessToken, selectedIndex)
// - 토큰과 선택된 탭의 인덱스를 입력받아 해당하는 데이터로
// -stock_chart_widget의 SummaryMajorIndex 실행

class SlideTab extends StatefulWidget {
  final int num;
  final String accessToken;

  const SlideTab({
    super.key,
    required this.num,
    required this.accessToken,
  });

  @override
  SlideTabState createState() => SlideTabState();
}

class SlideTabState extends State<SlideTab> {
  // 선택된 항목 인덱스
  int _selectedIndex = 0;

  void _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 탭 제목 리스트 함수
  List<String> _getTabTitles() {
    switch (widget.num) {
      case 0:
        return ["국내", "해외", "상품", "환율", "금리", "채권"];
      case 1:
        return ["상승률", "하락률", "거래량", "시가총액"];
      case 2:
        return ["temp"];
      default:
        return ["temp"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabTitles = _getTabTitles();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.08,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tabTitles.map((title) {
                final index = tabTitles.indexOf(title);
                return EachTab(
                  title: title,
                  index: index,
                  selectedIndex: _selectedIndex,
                  onSelected: _onSelected,
                );
              }).toList(),
            ),
          ),
          widget.num == 0
              ? SelectedIndexData0(
                  accessToken: widget.accessToken,
                  selectedIndex: _selectedIndex)
              : widget.num == 1
                  ? SelectedIndexData1(
                      accessToken: widget.accessToken,
                      selectedIndex: _selectedIndex)
                  : const Text(''),
        ],
      ),
    );
  }
}

// 슬라이드 탭 각 항목
class EachTab extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final Function(int) onSelected;

  const EachTab({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // provider.dart에 저장된 현재 테마 가져옴
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Transform.translate(
      offset: const Offset(-8, 0),
      child: TextButton(
        style: TextButton.styleFrom(
          // 최소크기 삭제
          minimumSize: const Size(50, 0),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          debugPrint('slide_tab_widget - index : $index');
          onSelected(index);
        },
        child: Text(
          title,
          style: TextStyle(
            color: selectedIndex == index
                ? Colors.orange // 선택된 항목은 주황색
                : (themeProvider.isDarkMode ? Colors.white : Colors.black),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// 슬라이드 탭 num = 0 : 주요 지수
class SelectedIndexData0 extends StatelessWidget {
  final String accessToken;
  final int selectedIndex;

  SelectedIndexData0({
    super.key,
    required this.accessToken,
    required this.selectedIndex,
  });

  // 인덱스에 해당하는 데이터
  final Map<int, List<Map<String, String>>> chartData = {
    0: [
      {"title": "KOSPI", "code": "0001"},
      {"title": "KOSDAQ", "code": "1001"},
    ],
    1: [
      {"title": "나스닥", "code": "2001"},
      {"title": "러셀", "code": "2002"},
      {"title": "S&P500", "code": "2003"},
      {"title": "다우존스", "code": "2004"},
    ],
    2: [
      {"title": "금", "code": "3001"},
      {"title": "은", "code": "3002"},
      {"title": "유가", "code": "3003"},
    ],
    3: [
      {"title": "KODEX 200", "code": "4001"},
      {"title": "TIGER MSCI", "code": "4002"},
    ],
    4: [
      {"title": "USD/KRW", "code": "5001"},
      {"title": "EUR/KRW", "code": "5002"},
    ],
    5: [
      {"title": "국채 3년", "code": "6001"},
      {"title": "국채 10년", "code": "6002"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    // 선택된 데이터
    final selectedData = chartData[selectedIndex] ?? [];

    return SizedBox(
      // 차지하는 공간( 높이 )
      height: selectedData.length <= 2
          ? 120
          : (selectedData.length == 3 ? 180 : 240),
      // color: Colors.greenAccent,
      child: ListView.builder(
        // key: ValueKey(selectedData),
        itemCount: selectedData.length,
        itemBuilder: (context, index) {
          final item = selectedData[index];
          return SizedBox(
            height: 60,
            child: SummaryMajorIndex(
              accessToken: accessToken,
              title: item['title']!,
              code: item["code"]!,
              height: 60,
            ),
          );
        },
      ),
    );
  }
}

// 슬라이드 탭 num = 1 : 실시간 랭킹
class SelectedIndexData1 extends StatelessWidget {
  final String accessToken;
  final int selectedIndex;

  SelectedIndexData1({
    super.key,
    required this.accessToken,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SummaryVolRank(
      // 한 칸 높이
      height: 40,
      accessToken: accessToken,
      selectedIndex: selectedIndex,
    );
  }
}
