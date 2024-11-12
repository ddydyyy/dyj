import 'dart:convert';
import 'package:finance/models/stock_chart_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// ref
// https://polygon.io/docs/stocks/get_v2_aggs_ticker__stocksticker__range__multiplier___timespan___from___to

class StockChartService {
  final String apiKey = 'vH9CqGMGHJc9TIDO540RgpbQrO1guSKW';
  final String baseUrl = 'https://api.polygon.io';

  Future<List<StockChartModel>> fetch5MinData(String symbol) async {
    final DateTime now = DateTime.now();
    // 미국은 한국보다 14시간정도 느림
    final String startDate = DateFormat('yyyy-MM-dd').format(
        now.subtract(Duration(days: 32)));
    final String endDate = DateFormat('yyyy-MM-dd').format(
        now.subtract(Duration(days: 2)));
    print('$startDate/$endDate');
    // final DateTime midnight =
    // DateTime(yesterday.year, yesterday.month, yesterday.day);

    // // 날짜를 YYYY-MM-DD 형식으로 변환
    // final String startDate = DateFormat('yyyy-MM-dd').format(midnight);
    // final String endDate = DateFormat('yyyy-MM-dd').format(yesterday);
    // print('${startDate}, ${endDate}');

    // 초단위로 요청은 유료인듯?
    // print('${midnight.millisecondsSinceEpoch ~/ 1000}/'
    //     '${yesterday.millisecondsSinceEpoch ~/ 1000}');

    final response = await http.get(Uri.parse(
        '$baseUrl/v2/aggs/ticker/$symbol/'
            'range/5/minute/'
            // '$yesterday/$yesterday?'
            '$startDate/$endDate?'
            // '${midnight.millisecondsSinceEpoch ~/ 1000}/'
            // '${yesterday.millisecondsSinceEpoch ~/ 1000}?'
            // '2023-11-10/2023-11-11?'
            'adjusted=true&sort=asc&'
            'apiKey=$apiKey'));

        // '${midnight.millisecondsSinceEpoch ~/ 1000}/'
            // '${now.millisecondsSinceEpoch ~/ 1000}?apiKey=$apiKey'));
    if (response.statusCode == 200) {
      // print('stock_chart_service - 응답 성공1');
      // print(' : ${response.body}');

      final data = json.decode(response.body);

      // 'results'가 null이면 빈 리스트를 반환하고, 그렇지 않으면 StockChartModel로 변환
      final results = data['results'] != null
          ? (data['results'] as List)
          .map((json) => StockChartModel.fromJson(json)) // 변환
          .toList() // List<StockChartModel>로 변환
          : <StockChartModel>[]; // 빈 리스트 반환

      print('stock_chart_service - 응답 성공');
      // print(' : $results');
      return results;
    } else {
      throw Exception('stock_chart_service - 응답 실패 : '
          '${response.statusCode}, ${response.reasonPhrase}');
    }
  }
}


// import 'dart:convert';
// import 'package:finance/models/stock_chart_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// ref
// https://polygon.io/docs/stocks/get_v2_aggs_grouped_locale_us_market_stocks__date
// -> Grouped Daily

// class StockChartService {
//   final String apiKey = 'vH9CqGMGHJc9TIDO540RgpbQrO1guSKW';
//   final String baseUrl = 'https://api.polygon.io';

//   Future<List<StockChartModel>> fetch5MinData() async {
//     final DateTime now = DateTime.now();
//     // 집계가 4일 전까지만 나오는듯?
//     final String startDate = DateFormat('yyyy-MM-dd').format(
//         now.subtract(Duration(days: 32)));
//     final String endDate = DateFormat('yyyy-MM-dd').format(
//         now.subtract(Duration(days: 4)));
//     print('$startDate/$endDate');
//
//     final response = await http.get(Uri.parse(
//         '$baseUrl/v2/aggs/grouped/locale/us/market/stocks/'
//             '$endDate?'
//             'adjusted=true&'
//             'apiKey=$apiKey'));
//
//     if (response.statusCode == 200) {
//       print('stock_chart_service - 응답 성공1');
//       print(' : ${response.body}');
//
//       final data = json.decode(response.body);
//
//       // 'results'가 null이면 빈 리스트를 반환하고, 그렇지 않으면 StockChartModel로 변환
//       final results = data['results'] != null
//           ? (data['results'] as List)
//           .map((json) => StockChartModel.fromJson(json)) // 변환
//           .toList() // List<StockChartModel>로 변환
//           : <StockChartModel>[]; // 빈 리스트 반환
//
//       print('stock_chart_service - 응답 성공');
//       print(' : $results');
//       return results;
//     } else {
//       throw Exception('stock_chart_service - 응답 실패 : '
//           '${response.statusCode}, ${response.reasonPhrase}');
//     }
//   }
// }