import 'package:finance/provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:finance/screens/home.dart';
import 'package:finance/screens/DY.dart';
import 'package:finance/screens/yb_home.dart';
import 'package:provider/provider.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _Start();
}

class _Start extends State<Start> {
  // 선택한 bottomBar 탭 인덱스
  int _selectedIndex = 0;

  // 탭 했을 때
  void _onItemTapped(int index) {
    setState(() {
      print('start33_bottomBarIndex : $index');
      // 선택한 인덱스를 저장
      _selectedIndex = index;
    });
  }

  // 페이지 이동
  final List<Widget> _navIndex = [
    const Home(),
    DY(),
    const yb_home(),
  ];

  @override
  Widget build(BuildContext context) {
    // provider에 저장된 currentTheme 가져오기
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Custom Theme Demo'),
          actions: [
            IconButton(
              icon: Icon(
                  themeProvider.isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
              // onPressed: _toggleTheme,
              onPressed: () {
                // provider에 있는 toggleTheme 실행
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            // 모든 페이지에 동일하게 적용될 패딩
            // padding: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(
              // horizontal: 100,
              vertical: 50,
            ),
            child: _navIndex.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: Container(
          // 다크모드 시 body와 bottom 구분을 위해
          // container로 테두리를 줌
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey, // 선 색상
                width: 0.5, // 선 두께
              ),
            ),
          ),
          child: BottomNavigationBar(
            // 탭 네개 이상 시 필요
            // 세개까지는 기본으로 설정됨
            type: BottomNavigationBarType.fixed,

            onTap: _onItemTapped,
            // currentIndex -> 여기 값이 업데이트 되면
            // flutter는 업데이트된 currentIndex값이 선택됐다고 인식하는듯
            currentIndex: _selectedIndex,

            // selectedItemColor: Colors.amber[800],
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
        ),
    );
  }
}




// import 'package:finance/provider/provider.dart';
// import 'package:finance/theme/theme.dart';
// import 'package:flutter/material.dart';
//
// import 'package:finance/screens/home.dart';
// import 'package:finance/screens/DY.dart';
// import 'package:finance/screens/yb_home.dart';
// import 'package:provider/provider.dart';
//
// class Start extends StatefulWidget {
//   const Start({super.key});
//
//   @override
//   State<Start> createState() => _Start();
// }
//
// class _Start extends State<Start> {
//   // 선택한 bottomBar 탭 인덱스
//   int _selectedIndex = 0;
//
//   // 탭 했을 때
//   void _onItemTapped(int index) {
//     setState(() {
//       print('start33_bottomBarIndex : $index');
//       // 선택한 인덱스를 저장
//       _selectedIndex = index;
//     });
//   }
//
//   // 페이지 이동
//   final List<Widget> _navIndex = [
//     const Home(),
//     const dy_temp(),
//     const yb_home(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // provider에 저장된 currentTheme 가져오기
//     final themeProvider = Provider.of<ThemeProvider>(context);
//
//     return MaterialApp(
//       // 앱 전체 테마
//       theme: themeProvider.currentTheme.themeData,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Custom Theme Demo'),
//           backgroundColor: themeProvider.currentTheme.primaryColor,
//           actions: [
//             IconButton(
//               icon: Icon(
//                   themeProvider.isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
//               // onPressed: _toggleTheme,
//               onPressed: () {
//                 // provider에 있는 toggleTheme 실행
//                 Provider.of<ThemeProvider>(context, listen: false)
//                     .toggleTheme();
//               },
//             ),
//           ],
//         ),
//         body: Padding(
//           // 모든 페이지에 동일하게 적용될 패딩
//           // padding: const EdgeInsets.all(16.0),
//           padding: const EdgeInsets.only(
//             left: 100,
//             right: 100,
//             top: 50,
//           ),
//           child: _navIndex.elementAt(_selectedIndex),
//         ),
//         bottomNavigationBar: Container(
//           // 다크모드 시 body와 bottom 구분을 위해
//           // container로 테두리를 줌
//           decoration: BoxDecoration(
//             border: Border(
//               top: BorderSide(
//                 color: Colors.grey, // 선 색상
//                 width: 0.5, // 선 두께
//               ),
//             ),
//           ),
//           child: BottomNavigationBar(
//             // 탭 네개 이상 시 필요
//             // 세개까지는 기본으로 설정됨
//             type: BottomNavigationBarType.fixed,
//
//             onTap: _onItemTapped,
//             // currentIndex -> 여기 값이 업데이트 되면
//             // flutter는 업데이트된 currentIndex값이 선택됐다고 인식하는듯
//             currentIndex: _selectedIndex,
//
//             // selectedItemColor: Colors.amber[800],
//             // unselectedItemColor: Colors.blue,
//             // unselectedFontSize = 12.0
//             // unselectedLabelStyle = TextStyle()
//             // 선택되지 않은 Item 의 label 노출 여부
//             // showUnselectedLabels: false,
//             // Item 선택 시 효과음 여부 - bool
//             // enableFeedback = false,
//             // backgroundColor: Colors.black,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home_filled),
//                 label: '홈',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.star),
//                 label: '관심_dy',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.assessment),
//                 label: '자산_yb',
//               ),
//               // BottomNavigationBarItem(
//               //   icon: Icon(Icons.account_circle_rounded),
//               //   label: 'My',
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
