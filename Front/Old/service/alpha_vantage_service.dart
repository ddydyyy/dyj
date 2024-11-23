// // services/kis_service.dart
// import 'dart:convert';
// import 'package:finance/provider/stock_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// import '../models/alpha_vantage_model.dart';
//
// // https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AAPL&interval=15min&apikey=YOUR_API_KEY
//
// class StockDataService {
//   final String baseUrl = 'https://www.alphavantage.co/query';
//   final String api_key = 'VF2Z9O5TSLG266X0';
//
//   Future<List<StockDataModel>?> stockData({required String symbol}) async {
//     const String function = 'TIME_SERIES_INTRADAY';
//     const String interval = '15min';
//     final url = Uri.parse('$baseUrl?function=$function&'
//         'symbol=$symbol&interval=$interval&apikey=$api_key');
//
//     try {
//       // API 요청
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         // JSON 형식으로 파싱( 변환 )
//         Map<String, dynamic> data = json.decode(response.body);
//         // print(data);
//
//         // .containsKey : Map 객체가 특정 키를 가지고 있는지 확인
//         if (data.containsKey('Time Series (15min)')) {
//           // 주식 데이터를 시간별로 변환하여 리스트로 반환
//           Map<String, dynamic> timeSeries = data['Time Series (15min)'];
//           // print('timeSeries : $timeSeries');
//
//           // 최신 날짜 추출 (가장 최신 날짜 기준으로 데이터 필터링)
//           final latestDate = _getLatestDate(timeSeries);
//           print('가장 최근 날짜 : $latestDate');
//
//           // 해당 날짜에 해당하는 데이터만 필터링
//           Map<String, dynamic> filteredData = _filterByDate(timeSeries, latestDate);
//
//
//           // 시간별 데이터 리스트
//           List<StockDataModel> stockDataList = [];
//
//           timeSeries.forEach((time, values) {
//             final stockData = StockDataModel.fromJson(time, values);
//             stockDataList.add(stockData);
//           });
//           return stockDataList;
//         } else {
//           throw Exception('StockDataService - model 생성 실패');
//         }
//       } else {
//         throw Exception('StockDataService - 응답 실패');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
//   // 가장 최신 날짜 추출하는 메서드
//   // {2024-11-13 19:45:00: {open: 2, high: 5 ...}, 2024-11-13 19:30:00:
//   String _getLatestDate(Map<String, dynamic> timeSeries) {
//     List<String> dates = timeSeries.keys.map((time) {
//       return time.split(' ')[0];  // 날짜 부분만 추출 (2024-11-13)
//     }).toList();
//
//     dates.sort((a, b) => b.compareTo(a));  // 최신 날짜가 앞에 오도록 정렬
//     return dates.first;  // 가장 최신 날짜 반환
//   }
//
// // 주어진 날짜에 해당하는 데이터만 필터링하는 메서드
//   // date : 가장 최신 날짜
//   Map<String, dynamic> _filterByDate(Map<String, dynamic> timeSeries, String date) {
//     return Map.fromEntries(
//       // 날짜만 비교해서 가장 최신 날짜와 같은지
//         timeSeries.entries.where((entry) =>
//         entry.key.split(' ')[0] == date)
//     );
//   }
// }
//
//
//
// // // services/kis_service.dart
// // import 'dart:convert';
// // import 'package:finance/models/stock_model.dart';
// // import 'package:finance/provider/stock_provider.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:provider/provider.dart';
// //
// // // https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=AAPL&interval=15min&apikey=YOUR_API_KEY
// //
// // class StockDataService {
// //   final String baseUrl = 'https://www.alphavantage.co/query';
// //   final String api_key = 'VF2Z9O5TSLG266X0';
// //
// //   Future<List<StockDataModel>?> stockData({required String symbol}) async {
// //     const String function = 'TIME_SERIES_INTRADAY';
// //     const String interval = '15min';
// //     final url = Uri.parse('$baseUrl?function=$function&'
// //         'symbol=$symbol&interval=$interval&apikey=$api_key');
// //
// //     try {
// //       // API 요청
// //       final response = await http.get(url);
// //
// //       if (response.statusCode == 200) {
// //         // JSON 형식으로 파싱( 변환 )
// //         Map<String, dynamic> data = json.decode(response.body);
// //         // print(data);
// //
// //         // .containsKey : Map 객체가 특정 키를 가지고 있는지 확인
// //         if (data.containsKey('Time Series (15min)')) {
// //           // 주식 데이터를 시간별로 변환하여 리스트로 반환
// //           Map<String, dynamic> timeSeries = data['Time Series (15min)'];
// //           // Map<String, Map<String, String>>
// //           // 시간 : { open : 123, high : 456, ... } -> Iterable 형태
// //           // print(rawTimeSeries);
// //
// //           // fromJson은 기본적으로 하나의 Map<String, dynamic>만을 받음
// //           // -> data.value만 저장할 수 있는데, 아래 entries를 써서
// //           // key값도 같이 저장한다는 소리인듯
// //           List<Future<StockDataModel?>> futures = timeSeries.entries.map((data) async {
// //             try {
// //               // 변경: async 함수로 호출하면서 error handling 추가
// //               final stockData = await StockDataModel.fromJson(data.key, data.value);
// //               print('StockDataService - 응답 성공: ${stockData.time}'); // 디버깅 로그
// //               return stockData;
// //             } catch (e) {
// //               print('Error loading stock data: $e'); // 에러 로그
// //               return null; // 실패 시 null 반환
// //             }
// //           }).toList();
// //           // Future.wait을 사용하여 모든 비동기 작업이 완료되길 기다림
// //           List<StockDataModel?> stockList = await Future.wait(futures);
// //
// //           // null을 제외한 값만 필터링
// //           stockList.removeWhere((element) => element == null);
// //
// //           print('StockDataService - model 생성 성공');
// //           return stockList.cast<StockDataModel>();
// //
// //           // List<StockDataModel> stockList = await Future.wait(timeSeries.entries.map((data) async {
// //           //   return await StockDataModel.fromJson(data.key, data.value);
// //           // }).toList());
// //           //
// //           // print('StockDataService - model 생성 성공');
// //           // return stockList;
// //         } else {
// //           throw Exception('StockDataService - model 생성 실패');
// //         }
// //       } else {
// //         throw Exception('StockDataService - 응답 실패');
// //       }
// //     } catch (e) {
// //       rethrow;
// //     }
// //   }
// // }
// //
