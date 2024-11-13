// services/kis_service.dart
import 'dart:convert';
import 'package:finance/models/test_model.dart';
import 'package:finance/provider/test_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class KISService {
  final String tr_id = 'FHKST01010100';
  final String baseUrl = 'https://openapi.koreainvestment.com:9443';
  final String appkey = 'PSxqSKoJkoHE997XzT09OCG4Efd1jTbsAxi6';
  final String appsecret =
      'riXSV1NsPY6G1uoukJaoXC/IKLGd0mLPByAOj2oVtCruAr6o38pmAVR4viJkiiAIWZ+CJPsr1Chuh/HvKnXAaHOGBgBv0ftPsT+hU43BtbXsC4MdPbpAmIlTLmnC0amIvS3FB6Bk+2w3sHJQIK9aEM2H0cI9sfJweuFzuDK3wfTaGfEalf8=';
  final String Content_Type = 'application/json; charset=UTF-8';

  Future<String?> getApi() async {
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

    print('status : ${response.statusCode}');
    print('response : ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['access_token'];
    } else {
      print('발급 실패 : ${response.statusCode}');
      print('response : ${response.body}');
      return null;
    }
  }

  // 국내주식 기간별 시세(일/주/월/년)
  Future<void> getStockData(accessToken) async {
    const path = 'uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'content-type': Content_Type,
      'authorization': 'Bearer ${accessToken}',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': tr_id,
      'custtype' : 'P',
    };
    final params = {
      // 기타 구분 코드
      'FID_ETC_CLS_CODE' : "",
      // 주식, ETF, ETN : J
      // ELW : W
      'FID_COND_MRKT_DIV_CODE': 'J',
      // 조회 종목 코드
      'FID_INPUT_ISCD': '005930',
      // 시간
      'FID_INPUT_HOUR_1' : '6000000',
      // 과거 데이터 포함 여부
      'FID_PW_DATA_INCU_YN' : 'Y',

      // 조회 시작일과 종료일 설정 (예: 2023년 1월 1일 ~ 1월 31일)
      'FID_INPUT_DATE_1' : '20230101',
      'FID_INPUT_DATE_2' : '20230131',

      'FID_PERIOD_DIV_CODE' : 'D',    // 일봉 데이터
      'FID_ORG_ADJ_PRC' : '1',        // 원주가 (0) 또는 수정주가 (1)

      // // 조회 시작일
      // 'FID_INPUT_DATE_1' : '20220501',
      // // 조회 종료일
      // 'FID_INPUT_DATE_2' : '20220530',
      // D / W / M / Y -> 일봉 / 주봉 / 월봉 / 년봉
      // 'FID_PERIOD_DIV_CODE' : 'D',
      // 0 : 수정주가 , 1 : 원주가
      // 'FID_ORG_ADJ_PRC' : '1',
    };

    final response = await http.get(
      url.replace(
        queryParameters: params,
      ),
      headers: headers,
    );

    print('getStockData___status : ${response.statusCode}');
    print('getStockData___response : ${response.body}');

    final temp = json.decode(response.body);
    // print(temp['output2']);
    // print('response : ${response.body['output']}');
    print('temp : ${temp['output']['stck_prpr']}');
    // JSON 파싱
    // final Map<String, dynamic> jsonData = json.decode(response.body);
    // // 'stck_prpr' 문자열을 숫자로 변환
    // final String priceString = jsonData['output']['stck_clpr'];
    //
    // final int price = int.parse(priceString); // 문자열을 정수로 변환
    //
    // print('output111 : $price');

  }

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
