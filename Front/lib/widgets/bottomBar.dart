import 'package:finance/screens/dy_temp.dart';
import 'package:finance/screens/home.dart';
import 'package:finance/screens/yb_home.dart';
import 'package:flutter/material.dart';


class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  // 선택한 탭 인덱스
  int _selectedIndex = 0;
  final List<Widget> _navIndex = [
    Home(),
    dy_temp(),
    yb_home(),
  ];

  // 탭 했을 때
  void _onItemTapped(int index) {
    setState(() {
      print('bottomBarIndex : $index');
      // 선택한 인덱스를 저장
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // 탭 네개 이상 시 필요
        // 세개까지는 기본으로 설정됨
        type: BottomNavigationBarType.fixed,

        onTap: _onItemTapped,
        // currentIndex -> 여기 값이 업데이트 되면
        // flutter는 업데이트된 currentIndex값이 선택됐다고 인식하는듯
        currentIndex: _selectedIndex,

        selectedItemColor: Colors.amber[800],
        // unselectedItemColor: Colors.blue,
        // unselectedFontSize = 12.0
        // unselectedLabelStyle = TextStyle()
        // 선택되지 않은 Item 의 label 노출 여부
        // showUnselectedLabels: false,
        // Item 선택 시 효과음 여부 - bool
        // enableFeedback = false,
        // backgroundColor: Colors.black,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '관심',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: '자산',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'My',
          ),
        ],
      ),

    );
  }
}
