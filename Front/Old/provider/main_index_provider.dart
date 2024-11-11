// import 'package:finance/service/api_service.dart';
// import 'package:flutter/material.dart';
// import 'package:finance/Old/models/kospi.dart';
//
// class KospiProvider with ChangeNotifier {
//   // 데이터 저장 변수
//   // 변수 형식 -> kospi.dart Model
//   List<KospiModel>? _kospiData;
//
//   List<KospiModel>? get kospiData => _kospiData;
//
//   // 생성자에서 데이터 초기화
//   // -> main.dart 에서 처음 runApp실행하면서
//   // ChangeNotifierProvider(create: (_) => KospiProvider()),
//   // 할 때 KospiProvider가 생성되면서 _fetchKospiData() 실행하면서 저장
//   KospiProvider() {
//     _fetchKospiData();
//   }
//
//   // 데이터를 가져와서 _kospiData에 저장하고 UI 갱신
//   Future<void> _fetchKospiData() async {
//     try {
//       _kospiData = await KospiService.getKospi();
//       print('main_index_provider_16 성공');
//       // 데이터 변경 시 UI에 알림
//       notifyListeners();
//     } catch (e) {
//       print('main_index_provider_20 오류 발생: $e');
//     }
//   }
// }