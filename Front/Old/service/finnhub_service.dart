// // lib/services/finnhub_service.dart
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/finnhub_model.dart';
//
// class StockDataService {
//   final String _apiKey = 'csouqu1r01qt3r34hmi0csouqu1r01qt3r34hmig'; // API 키
//
//   // 단일 주식 데이터를 가져오는 메서드
//   Future<StockDataModel> getData(String symbol) async {
//     final url = 'https://finnhub.io/api/v1/quote?symbol='
//         '$symbol&token=$_apiKey';
//
//     try {
//       // 비동기 요청
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         // String -> Json
//         final data = json.decode(response.body);
//
//         // 필요 데이터로 StockModel 생성
//         return StockDataModel(
//           open: data['o']?.toDouble() ?? 0.0,
//           high: data['h']?.toDouble() ?? 0.0,
//           low: data['l']?.toDouble() ?? 0.0,
//           close: data['c']?.toDouble() ?? 0.0,
//           time: DateTime.now(),
//           // 현재 시간을 사용 (타임스탬프 대신)
//           // 수정 필요
//           volume: 0, // API에서 제공되지 않으면 0으로 설정
//         );
//       } else {
//         throw Exception('stock_data_service - 응답 실패 : '
//             '${response.statusCode}');
//       }
//     } catch (e) {
//       // print('stock_data_service - Error: $e');
//       throw Exception('stock_data_service - Error : $e');
//     }
//   }
// }
