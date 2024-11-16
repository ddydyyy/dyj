import 'package:finance/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  // 검색창 위젯
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        // 아이콘 + 검색창
        Row(
          children: [
            // 아이콘
            const Icon(Icons.insert_emoticon),
            const Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
            ),
            Expanded(
              // TextField는 크기가 정해져 있지 않음
              // 왜인지 모르지만, 차지하는 공간이 계속 변하면서
              // 무한로딩되는 오류가 생기는듯
              // Expanded로 부모 위젯의 남은 공간을 모두 차지하게 해
              // 공간을 재할당하지 않게 해서 무한로딩 방지하는듯?
              child: TextField(
                style: themeProvider.isDarkMode
                    ? AppTheme.darkTheme.bodyMediumStyle
                    : AppTheme.lightTheme.bodyMediumStyle,
                decoration: const InputDecoration(
                  hintText: '주식, 메뉴, 상품, 뉴스를 검색하세요',
                  border: InputBorder.none, // 밑줄 제거
                ),
              ),
            ),
          ],
        ),
        // 검색창 아래 밑줄
        Container(
          height: 2, // 밑줄의 두께
          color: Colors.grey, // 밑줄 색상
        ),
      ],
    );
  }
}
