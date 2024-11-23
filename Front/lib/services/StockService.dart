// services/StockService.dart

import 'dart:convert';
import 'package:finance/models/StockModel.dart';
import 'package:http/http.dart' as http;

// koreainvestment( 한국투자증권 )
class StockService {
  final String baseUrl = 'https://openapi.koreainvestment.com:9443';
  final String appkey = 'PSxqSKoJkoHE997XzT09OCG4Efd1jTbsAxi6';
  final String appsecret =
      'riXSV1NsPY6G1uoukJaoXC/IKLGd0mLPByAOj2oVtCruAr6o38pmAVR4viJkiiAIWZ+CJPsr1Chuh/HvKnXAaHOGBgBv0ftPsT+hU43BtbXsC4MdPbpAmIlTLmnC0amIvS3FB6Bk+2w3sHJQIK9aEM2H0cI9sfJweuFzuDK3wfTaGfEalf8=';
  final String content_type = 'application/json; charset=utf-8';

  // api 토큰 발급
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
      'Content-Type': content_type,
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

  // 주식당일분봉조회 -> 개별주식
  Future<List<StockMinData>> getMinData(accessToken) async {
    const path =
        'uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'content-type': content_type,
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

  // 주식현재가 시세 -> 개별주식
  Future<StockDataModel> getStockData(accessToken, code) async {
    const path = 'uapi/domestic-stock/v1/quotations/inquire-price';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'authorization': 'Bearer ${accessToken}',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHKST01010100',
    };

    final params = {
      // J : 주식, ETF
      'FID_COND_MRKT_DIV_CODE': 'J',
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
        print('getStockData_응답 성공');
        // print('${stockData}');
        // print('getStockData_현재가 : ${stockData['stck_prpr']}');

        final result = StockDataModel.fromJson(stockData);
        return result;
      } else {
        throw Exception('getStockData_응답 실패 ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getStockData_에러: $e');
    }
  }

  // 국내업종 현재지수 -> Kospi Kosdaq 등
  Future<MajorIndexModel> getMajorIndex(accessToken, code) async {
    const path = 'uapi/domestic-stock/v1/quotations/inquire-index-price';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'content-type' : content_type,
      'authorization': 'Bearer ${accessToken}',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHPUP02100000',
      'custtype' : 'P',
    };

    final params = {
      // 업종 'U'
      'FID_COND_MRKT_DIV_CODE': 'U',
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
        print('getMajorIndex_응답 성공');
        // print('${stockData}');
        // print('getMajorIndex_현재가 : ${stockData['bstp_nmix_prpr']}');

        final result = MajorIndexModel.fromJson(stockData);
        return result;
      } else {
        throw Exception('getMajorIndex_응답 실패 ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getMajorIndex_에러: $e');
    }
  }




}
