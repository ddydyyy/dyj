import 'package:flutter/material.dart';

import 'package:finance/screens/home.dart';
import 'package:finance/screens/dy_temp.dart';
import 'package:finance/screens/yb_home.dart';


class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _Start();
}

class _Start extends State<Start> {
  // 선택한 탭 인덱스
  int _selectedIndex = 0;
  final List<Widget> _navIndex = [
    const Home(),
    const dy_temp(),
    const yb_home(),
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
      body: _navIndex.elementAt(_selectedIndex),
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

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: '관심_dy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: '자산_yb',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.account_circle_rounded),
          //   label: 'My',
          // ),
        ],
      ),

    );
  }
}
