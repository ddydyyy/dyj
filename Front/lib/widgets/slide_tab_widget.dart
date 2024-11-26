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
        return ["국내", "해외", "환율", "국채"];
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
          // debugPrint('slide_tab_widget - index : $index');
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
      {"title": "NASDAQ", "code": "COMP"},
      {"title": "S&P500", "code": "SPX"},
      {"title": "DOW", "code": ".DJI"},
    ],
    2: [
      {"title": "원/달러", "code": "FX@KRW"},
      {"title": "원/엔(100)", "code": "FX@KRWJS"},
    ],
    3: [
      {"title": "국고채1년", "code": "Y0104"},
      {"title": "국고채3년", "code": "Y0101"},
      {"title": "국고채5년", "code": "Y0105"},
      {"title": "국고채10년", "code": "Y0106"},
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
            child:
            SummaryMajorIndex(
              index: selectedIndex,
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
  final double height = 40;
  final String accessToken;
  final int selectedIndex;

  const SelectedIndexData1({
    super.key,
    required this.accessToken,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return SummaryChangeRateRank(
          height: height,
          accessToken: accessToken,
          sort: '0',
        );
      case 1:
        return SummaryChangeRateRank(
          height: height,
          accessToken: accessToken,
          sort: '1',
        );
      case 2:
        return SummaryVolRank(
          height: height,
          accessToken: accessToken,
        );
      default:
        return SummaryMarketCapRank(
          accessToken: accessToken,
          height: height,
        );
    }
  }
}
