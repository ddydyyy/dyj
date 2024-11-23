// widgets/SlideWidget.dart

import 'package:finance/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideTab extends StatefulWidget {
  const SlideTab({super.key});

  @override
  SlideTabState createState() => SlideTabState();
}

class SlideTabState extends State<SlideTab> {
  // 선택된 항목 인덱스
  int _selectedIndex = 0;

  // 스크롤 컨트롤러
  final ScrollController _scrollController = ScrollController();

  // 버튼 표시 여부
  // bool _showButtons = false;

  void _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // // 오른쪽 스크롤
  // void _scrollRight() {
  //   _scrollController.animateTo(
  //     // 스크롤 이동 거리
  //     _scrollController.offset + 100,
  //     // 이동에 걸리는 시간
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }
  //
  // // 왼쪽 스크롤
  // void _scrollLeft() {
  //   _scrollController.animateTo(
  //     _scrollController.offset - 100,
  //     duration: const Duration(milliseconds: 300),
  //     curve: Curves.easeInOut,
  //   );
  // }

  @override
  // void initState() {
  //   super.initState();
  //   // 첫 번째 렌더링 이후에 버튼 표시 여부 확인
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _checkButtonVisibility();
  //   });
  //   _scrollController.addListener(_checkButtonVisibility);
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.removeListener(_checkButtonVisibility);
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // // 버튼 표시 여부 결정
  // void _checkButtonVisibility() {
  //   setState(() {
  //     // 스크롤이 오른쪽으로 이동 가능하면 버튼 표시
  //     _showButtons =
  //         _scrollController.position.maxScrollExtent > _scrollController.offset;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
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
