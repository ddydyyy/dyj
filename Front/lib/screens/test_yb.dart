// import 'package:finance/Page/home.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// // StatelessWidget : 앱 시작 시 랜더링 후 불변
// // StatefulWidget : 각종 상호작용에 따라 UI 변경
import 'package:flutter/material.dart';

class TestYB extends StatelessWidget {
  const TestYB({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
// class Yb_home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Home',
//       home: Scaffold(
//         body: ListView(
//           children: [
//             SearchBox(),
//             const ChartBox(
//               title: '어제 사람들이 관심있던 ETF/ETN',
//               subtitle: 'This is a custom card widget.',
//             ),
//             InvestmentCalendarWidget(), // 캘린더 위젯 추가
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // 투자 캘린더 위젯을 StatefulWidget으로 정의
// class InvestmentCalendarWidget extends StatefulWidget {
//   @override
//   _InvestmentCalendarWidgetState createState() => _InvestmentCalendarWidgetState();
// }
//
// class _InvestmentCalendarWidgetState extends State<InvestmentCalendarWidget> {
//   List<DateTime> weekDates = []; // 현재 주의 날짜를 저장할 리스트
//   bool showFullMonth = false; // 전체 월을 표시할지 여부를 결정하는 변수
//
//   @override
//   void initState() {
//     super.initState();
//     _generateCurrentWeek(); // 위젯이 처음 생성될 때 현재 주 날짜를 생성하여 초기화
//   }
//
//   // 현재 주의 날짜를 생성하는 메서드
//   void _generateCurrentWeek() {
//     DateTime today = DateTime.now(); // 오늘 날짜를 가져옴
//     int weekday = today.weekday; // 오늘이 무슨 요일인지(1: 월요일, 7: 일요일) 가져옴
//     weekDates = List.generate(7, (index) {
//       return today.subtract(Duration(days: weekday - 1 - index)); // 월요일을 기준으로 날짜를 계산하여 추가
//     });
//     setState(() {}); // 상태를 갱신하여 UI 업데이트
//   }
//
//   // 현재 월의 모든 날짜를 생성하는 메서드
//   void _generateCurrentMonth() {
//     DateTime today = DateTime.now(); // 오늘 날짜를 가져옴
//     DateTime firstDayOfMonth = DateTime(today.year, today.month, 1); // 이번 달의 첫 번째 날짜 가져옴
//     int daysInMonth = DateTime(today.year, today.month + 1, 0).day; // 이번 달의 일 수 가져옴
//     weekDates = List.generate(daysInMonth, (index) {
//       return firstDayOfMonth.add(Duration(days: index)); // 첫째 날부터 마지막 날까지 날짜 생성
//     });
//     setState(() {}); // 상태를 갱신하여 UI 업데이트
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
//       children: [
//         // 헤더 부분
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // 패딩 추가
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양 끝 정렬
//             children: [
//               Text(
//                 "투자캘린더",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // 텍스트 스타일 설정
//               ),
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     showFullMonth = !showFullMonth; // 버튼을 누르면 월 전체 보기가 토글됨
//                     showFullMonth ? _generateCurrentMonth() : _generateCurrentWeek(); // 월 전체 보기 여부에 따라 날짜 생성 메서드 호출
//                   });
//                 },
//                 child: Text("더보기", style: TextStyle(color: Colors.orange)), // 버튼 텍스트 스타일 설정
//               ),
//             ],
//           ),
//         ),
//         // 가로 날짜 선택기
//         Container(
//           height: 70, // 날짜 선택기의 높이 설정
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal, // 가로 방향 스크롤
//             itemCount: weekDates.length, // 날짜 리스트의 길이만큼 아이템 생성
//             itemBuilder: (context, index) {
//               bool isSelected = (weekDates[index].day == DateTime.now().day); // 오늘 날짜인지 확인하여 선택 상태 설정
//               return Container(
//                 width: 50, // 날짜 아이템의 너비 설정
//                 margin: EdgeInsets.symmetric(horizontal: 4), // 날짜 아이템 사이 간격 설정
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.orange : Colors.transparent, // 선택된 날짜 배경색 설정
//                   borderRadius: BorderRadius.circular(8), // 모서리를 둥글게 설정
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
//                   children: [
//                     Text(
//                       DateFormat.E('ko').format(weekDates[index]), // 요일을 한글로 표시
//                       style: TextStyle(
//                         color: Colors.white, // 글자 색상 설정
//                         fontSize: 16, // 글자 크기 설정
//                       ),
//                     ),
//                     SizedBox(height: 4), // 글자 사이 여백 설정
//                     Text(
//                       weekDates[index].day.toString(), // 날짜 숫자 표시
//                       style: TextStyle(
//                         color: Colors.white, // 글자 색상 설정
//                         fontSize: 16, // 글자 크기 설정
//                         fontWeight: FontWeight.bold, // 글자 굵기 설정
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         // 이벤트 목록
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // 패딩 설정
//           child: Column(
//             children: events.map((event) => EventItem(event: event)).toList(), // 각 이벤트를 EventItem으로 생성
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // 이벤트 데이터 모델 클래스
// class CalendarEvent {
//   final String country; // 국가 이름 저장
//   final String name; // 이벤트 이름 저장
//
//   CalendarEvent({required this.country, required this.name}); // 생성자 정의
// }
//
// // 이벤트 아이템 위젯 (각 이벤트를 표시)
// class EventItem extends StatelessWidget {
//   final CalendarEvent event; // 이벤트 데이터
//
//   EventItem({required this.event}); // 생성자 정의
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0), // 아이템 간 세로 여백
//       child: Row(
//         children: [
//           // 국가에 따른 아이콘 표시
//           if (event.country == "USA")
//             Icon(Icons.flag, color: Colors.red, size: 24) // 미국 국기 아이콘
//           else
//             Icon(Icons.bar_chart, color: Colors.green, size: 24), // 그 외 국가 아이콘
//           SizedBox(width: 12), // 아이콘과 텍스트 사이 여백
//           // 이벤트 설명
//           Expanded(
//             child: Text(
//               event.name,
//               style: TextStyle(fontSize: 16, color: Colors.white), // 글자 스타일 설정
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // 이벤트 목록 샘플 데이터
// final List<CalendarEvent> events = [
//   CalendarEvent(country: "USA", name: "미국 내구재 주문(8월.P)"),
//   CalendarEvent(country: "USA", name: "미국 개인소비(2Q T)"),
//   CalendarEvent(country: "Microtech", name: "마이크론 테크놀로지 실적발표"),
// ];
