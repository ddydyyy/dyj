// services/kis_service.dart
import 'dart:convert';
import 'package:finance/models/test_model.dart';
import 'package:finance/provider/test_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:collection';

class StockService {
  // final String tr_id = 'FHKST01010100';
  final String baseUrl = 'https://openapi.koreainvestment.com:9443';
  final String appkey = 'PSxqSKoJkoHE997XzT09OCG4Efd1jTbsAxi6';
  final String appsecret =
      'riXSV1NsPY6G1uoukJaoXC/IKLGd0mLPByAOj2oVtCruAr6o38pmAVR4viJkiiAIWZ+CJPsr1Chuh/HvKnXAaHOGBgBv0ftPsT+hU43BtbXsC4MdPbpAmIlTLmnC0amIvS3FB6Bk+2w3sHJQIK9aEM2H0cI9sfJweuFzuDK3wfTaGfEalf8=';

  // final String Content_Type = 'application/json; charset=UTF-8';
  final String Content_Type = 'application/json; charset=utf-8';

  // api
  Future<String?> getToken() async {
    const path = 'oauth2/tokenP';
    final url = Uri.parse('$baseUrl/$path');

    // 요청에 포함할 JSON 형식의 데이터
    // -> Format : JSON 이라고 API 문서에 나옴
    final body = jsonEncode({
      'grant_type': 'client_credentials',
      'appkey': appkey,
      'appsecret': appsecret,
    });

    // 요청 헤더 설정
    final headers = {
      'Content-Type': Content_Type,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // print('status : ${response.statusCode}');
    // print('response : ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('getToken_발급 성공');
      return jsonResponse['access_token'];
    } else {
      print('getToken_발급 실패 : ${response.statusCode}, response : ${response.body}');
      return null;
    }
  }

  // 주식당일분봉조회
  Future<List<StockMinData>> getMinData(accessToken) async {
    const path =
        'uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'content-type': Content_Type,
      'authorization': 'Bearer ${accessToken}',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHKST03010200',
      'custtype': 'P',
    };

    DateTime now = DateTime.now();
    String formattedNow =
        '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
    int time = int.parse(formattedNow);
    // print('time : $time');
    // print('hour : ${now.hour}');

    // 변경된 부분: 정렬을 위한 일반 List 선언
    List<StockMinData> resultList = [];

    for (int i = 000000; i < (time + 3000); i += 3000) {
      String nowTime = i.toString().padLeft(6, '0');
      // print('i : $i');
      // print('nowTime : $nowTime');
      final params = {
        'FID_ETC_CLS_CODE': "",
        'FID_COND_MRKT_DIV_CODE': 'J',
        'FID_INPUT_ISCD': '005930',
        'FID_INPUT_HOUR_1': nowTime,
        'FID_PW_DATA_INCU_YN': 'N',
      };

      final response = await http.get(
        url.replace(
          queryParameters: params,
        ),
        headers: headers,
      );
      // print('status : ${response.statusCode}');

      if (response.statusCode == 200) {
        final temp = json.decode(response.body);
        // print('temp : $temp');

        // output2 데이터를 가져와 StockData로 변환 후 resultList에 추가
        List<StockMinData> filteredData = (temp['output2'] as List)
            .map((item) => StockMinData.fromJson({
                  'stck_cntg_hour': item['stck_cntg_hour'],
                  'stck_prpr': item['stck_prpr'],
                }))
            .toList();
        for (var stockData in filteredData) {
          if (!resultList
              .any((data) => data.stck_cntg_hour == stockData.stck_cntg_hour)) {
            resultList.add(stockData);
          }
        }

        // 변경된 부분: 정렬할 리스트에 데이터 추가
        // resultList.addAll(filteredData);
      } else {
        throw Exception('Failed to load stock data');
      }
    }

    print('모델 생성 성공');

    // 변경된 부분: 시간 순으로 정렬
    resultList.sort((a, b) => a.stck_cntg_hour.compareTo(b.stck_cntg_hour));
    for (int i = 0; i < resultList.length; i++) {
      print('stock_cntg_hour : ${resultList[i].stck_cntg_hour}');
      print('stck_prpr : ${resultList[i].stck_prpr}');
    }

    return resultList;
  }

  // 주식현재가 시세
  Future<CurrentStockPrice> getStockData(accessToken, code) async {
    const path = 'uapi/domestic-stock/v1/quotations/inquire-price';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'authorization': 'Bearer ${accessToken}',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHKST01010100',
    };

    final params = {
      'FID_COND_MRKT_DIV_CODE': 'J',
      // 'FID_INPUT_ISCD': '005930',
      'FID_INPUT_ISCD': code,
    };

    final response = await http.get(
      url.replace(
        queryParameters: params,
      ),
      headers: headers,
    );

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // 데이터 추출
        final stockData = data['output'];
        // print('getStockData_응답 성공 : ${stockData}');
        // print('getStockData_현재가 : ${stockData['stck_prpr']}');
        final result = CurrentStockPrice.fromJson(stockData);
        return result;

        // return stockData;
      } else {
        throw Exception('getStockData_응답 실패 ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getStockData_에러: $e');
    }
  }

// // 주식 당일 분봉 조회
// Future<List<StockData>> getStockData(accessToken) async {
//   const path =
//       'uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice';
//   final url = Uri.parse('$baseUrl/$path');
//
//   final headers = {
//     'content-type': Content_Type,
//     'authorization': 'Bearer ${accessToken}',
//     'appKey': appkey,
//     'appSecret': appsecret,
//     'tr_id': 'FHKST03010200',
//     'custtype': 'P',
//   };
//
//   DateTime now = DateTime.now();
//   String formattedNow =
//       '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
//   int time = int.parse(formattedNow);
//   print('time : $time');
//
//   List<StockData> resultList = [];
//
//   for (int i = 093000; i < (time + 3000); i = i + 3000) {
//     print('i : $i');
//     // 6자리 시간 포맷으로 맞추기
//     String nowTime = i.toString().padLeft(6, '0');  // 6자리로 맞춤
//
//     final params = {
//       // 기타 구분 코드
//       'FID_ETC_CLS_CODE': "",
//       // 주식, ETF, ETN : J
//       // ELW : W
//       'FID_COND_MRKT_DIV_CODE': 'J',
//       // 조회 종목 코드
//       'FID_INPUT_ISCD': '005930',
//       // 시간
//       'FID_INPUT_HOUR_1': nowTime,
//       // 과거 데이터 포함 여부
//       'FID_PW_DATA_INCU_YN': 'N',
//     };
//
//     final response = await http.get(
//       url.replace(
//         queryParameters: params,
//       ),
//       headers: headers,
//     );
//
//     if (response.statusCode == 200) {
//       final temp = json.decode(response.body);
//
//       // output2에서 데이터를 가져와 StockData로 변환 후 resultList에 추가
//       List<StockData> filteredData = (temp['output2'] as List)
//           .map((item) => StockData.fromJson({
//                 'stck_cntg_hour': item['stck_cntg_hour'],
//                 'stck_prpr': item['stck_prpr'],
//               }))
//           .toList();
//
//       resultList.addAll(filteredData); // 결과 목록에 추가
//
//     } else {
//       throw Exception('Failed to load stock data');
//     }
//   }
//   print('모델 생성 성공');
//   for (int i=0; i<resultList.length; i++) {
//     print(resultList[i].stck_cntg_hour);
//   }
//
//   return resultList; // 최종적으로 모든 데이터를 포함한 리스트 반환
// }

// // 주식 당일 분봉 조회
// Future<List<StockData>> getStockData(accessToken) async {
//   const path =
//       'uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice';
//   final url = Uri.parse('$baseUrl/$path');
//
//   final headers = {
//     'content-type': Content_Type,
//     'authorization': 'Bearer ${accessToken}',
//     'appKey': appkey,
//     'appSecret': appsecret,
//     'tr_id': 'FHKST03010200',
//     'custtype': 'P',
//   };
//   final params = {
//     // 기타 구분 코드
//     'FID_ETC_CLS_CODE': "",
//     // 주식, ETF, ETN : J
//     // ELW : W
//     'FID_COND_MRKT_DIV_CODE': 'J',
//     // 조회 종목 코드
//     'FID_INPUT_ISCD': '005930',
//     // 시간
//     'FID_INPUT_HOUR_1': '123000',
//     // 과거 데이터 포함 여부
//     'FID_PW_DATA_INCU_YN': 'N',
//   };
//
//   final response = await http.get(
//     url.replace(
//       queryParameters: params,
//     ),
//     headers: headers,
//   );
//
//   // 응답이 성공적일 경우
//   if (response.statusCode == 200) {
//     // 응답 데이터 (JSON) 파싱
//     // Map<String, dynamic> responseData = json.decode(response.body);
//     final temp = json.decode(response.body);
//
//     // print('responseData : $responseData');
//
//     List<StockData> filteredData = (temp['output2'] as List)
//         .map((item) => StockData.fromJson({
//               'stck_cntg_hour': item['stck_cntg_hour'],
//               'stck_prpr': item['stck_prpr'],
//             }))
//         .toList();
//     print('모델 생성 성공');
//     DateTime now = DateTime.now();
//     String formattedTime =
//         '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
//     int abc = int.parse(formattedTime);
//
//     return filteredData;
//   } else {
//     // 에러 발생 시 예외 처리
//     throw Exception('Failed to load stock data');
//   }

//
// print('getStockData___status : ${response.statusCode}');
// print('getStockData___response : ${response.body}');
//
// Map<String, dynamic> responseData = json.decode(response.body);
// final temp = json.decode(response.body);
// // print(temp['output2']);
// // print('response : ${response.body['output']}');
// print('temp : ${temp['output2']}');
//
// // output2 리스트에서 필요한 데이터만 추출하여 새로운 리스트에 저장
// // [{stck_bsop_date: 20241114, ... }, { }, { }, ... ]
// // -> string : dynamic(숫자)인 Map(key-value) 형태를 map함수 돌림
// List<StockData> filteredData = temp['output2'].map<Map<String, dynamic>>((item) {
//   return {
//     'stck_cntg_hour': item['stck_cntg_hour'],
//     'stck_prpr': item['stck_prpr']
//   };
// }).toList();
//
// // 결과 확인
// print('Filtered Data: $filteredData');
//
// // JSON 파싱
// // final Map<String, dynamic> jsonData = json.decode(response.body);
// // // 'stck_prpr' 문자열을 숫자로 변환
// // final String priceString = jsonData['output']['stck_clpr'];
// //
// // final int price = int.parse(priceString); // 문자열을 정수로 변환
// //
// // print('output111 : $price');

// }

// // 국내주식 기간별 시세(일/주/월/년)
// Future<void> getStockData(accessToken) async {
//   const path = 'uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice';
//   final url = Uri.parse('$baseUrl/$path');
//
//   final headers = {
//     'content-type': Content_Type,
//     'authorization': 'Bearer ${accessToken}',
//     'appKey': appkey,
//     'appSecret': appsecret,
//     'tr_id': tr_id,
//     'custtype' : 'P',
//   };
//   final params = {
//     // 기타 구분 코드
//     'FID_ETC_CLS_CODE' : "",
//     // 주식, ETF, ETN : J
//     // ELW : W
//     'FID_COND_MRKT_DIV_CODE': 'J',
//     // 조회 종목 코드
//     'FID_INPUT_ISCD': '005930',
//     // 시간
//     'FID_INPUT_HOUR_1' : '6000000',
//     // 과거 데이터 포함 여부
//     'FID_PW_DATA_INCU_YN' : 'Y',
//
//     // 조회 시작일과 종료일 설정 (예: 2023년 1월 1일 ~ 1월 31일)
//     'FID_INPUT_DATE_1' : '20230101',
//     'FID_INPUT_DATE_2' : '20230131',
//
//     'FID_PERIOD_DIV_CODE' : 'D',    // 일봉 데이터
//     'FID_ORG_ADJ_PRC' : '1',        // 원주가 (0) 또는 수정주가 (1)
//
//     // // 조회 시작일
//     // 'FID_INPUT_DATE_1' : '20220501',
//     // // 조회 종료일
//     // 'FID_INPUT_DATE_2' : '20220530',
//     // D / W / M / Y -> 일봉 / 주봉 / 월봉 / 년봉
//     // 'FID_PERIOD_DIV_CODE' : 'D',
//     // 0 : 수정주가 , 1 : 원주가
//     // 'FID_ORG_ADJ_PRC' : '1',
//   };
//
//   final response = await http.get(
//     url.replace(
//       queryParameters: params,
//     ),
//     headers: headers,
//   );
//
//   print('getStockData___status : ${response.statusCode}');
//   print('getStockData___response : ${response.body}');
//
//   final temp = json.decode(response.body);
//   // print(temp['output2']);
//   // print('response : ${response.body['output']}');
//   print('temp : ${temp['output']}');
//   // JSON 파싱
//   // final Map<String, dynamic> jsonData = json.decode(response.body);
//   // // 'stck_prpr' 문자열을 숫자로 변환
//   // final String priceString = jsonData['output']['stck_clpr'];
//   //
//   // final int price = int.parse(priceString); // 문자열을 정수로 변환
//   //
//   // print('output111 : $price');
//
// }

// // 주식현재가 시세
// Future<void> getStockData(accessToken) async {
//   final path = 'uapi/domestic-stock/v1/quotations/inquire-price';
//   final url = Uri.parse('$baseUrl/$path');
//
//   final headers = {
//     // 'Content-Type': Content_Type,
//     'authorization': 'Bearer ${accessToken}',
//     'appKey': appkey,
//     'appSecret': appsecret,
//     'tr_id': tr_id,
//   };
//   final params = {
//     // 주식, ETF, ETN : J
//     // ELW : W
//     'FID_COND_MRKT_DIV_CODE': 'J',
//     // 조회 종목 코드
//     'FID_INPUT_ISCD': '005930',
//   };
//
//   final response = await http.get(
//     url.replace(queryParameters: params),
//     headers: headers,
//   );
//
//   print('getStockData___status : ${response.statusCode}');
//   print('getStockData___response : ${response.body}');
// }
}
