// widgets/SlideWidget.dart

import 'package:finance/provider/theme_provider.dart';
import 'package:finance/widgets/stock_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideTab extends StatefulWidget {
  final String accessToken;

  const SlideTab({
    super.key,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          // controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              EachTab(
                title: "국내",
                index: 0,
                selectedIndex: _selectedIndex,
                onSelected: _onSelected,
              ),
              EachTab(
                title: "해외",
                index: 1,
                selectedIndex: _selectedIndex,
                onSelected: _onSelected,
              ),
              EachTab(
                title: "원자재",
                index: 2,
                selectedIndex: _selectedIndex,
                onSelected: _onSelected,
              ),
              EachTab(
                title: "ETF",
                index: 3,
                selectedIndex: _selectedIndex,
                onSelected: _onSelected,
              ),
              EachTab(
                title: "환율",
                index: 4,
                selectedIndex: _selectedIndex,
                onSelected: _onSelected,
              ),
              EachTab(
                title: "채권",
                index: 5,
                selectedIndex: _selectedIndex,
                onSelected: _onSelected,
              ),
            ],
          ),
        ),
        // 선택된 인덱스와 액세스 토큰을 StockChart로 전달
        SelectedIndexData(
          accessToken: widget.accessToken,
          selectedIndex: _selectedIndex,
        ),
      ],
    );
  }
}

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

    return TextButton(
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
    );
  }
}

class SelectedIndexData extends StatelessWidget {
  final String accessToken;
  final int selectedIndex;

  // 인덱스에 해당하는 데이터
  final Map<int, List<Map<String, String>>> chartData = {
    0: [
      {"title": "코스닥", "code": "1001"},
      {"title": "코스피", "code": "0001"},
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

  SelectedIndexData({
    super.key,
    required this.accessToken,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    // 선택된 데이터
    final selectedData = chartData[selectedIndex] ?? [];

    return Container(
      // 차지하는 공간( 높이 )
      height: (selectedData.length <= 2)
          ? 120
          : (selectedData.length == 3)
              ? 180
              : (selectedData.length == 4)
                  ? 240
                  : 270,
      color: Colors.greenAccent,
      child: ListView.builder(
        itemCount: selectedData.length,
        itemBuilder: (context, index) {
          final item = selectedData[index];
          return SizedBox(
            height: 60,
            child: SummaryMajorIndex(
              accessToken: accessToken,
              code: item["code"]!,
              height: 60,
            ),
          );
        },
      ),
    );
  }
}
