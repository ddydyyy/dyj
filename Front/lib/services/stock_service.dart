// services/stock_service.dart

import 'dart:convert';
import 'package:finance/models/stock_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

// koreainvestment( 한국투자증권 )
// getToken() : api 토큰 발급
// getMinData(accessToken) : 주식당일 분봉조회( 개별주식 )
// getStockData(accessToken, code) : 주식현재가 시세( 개별주식 )
// getMajorIndex(accessToken, code) : 국내업종 현재지수 ( Kospi, Kosdaq 등 )
class StockService {
  final String baseUrl = 'https://openapi.koreainvestment.com:9443';
  final String appkey = 'PSxqSKoJkoHE997XzT09OCG4Efd1jTbsAxi6';
  final String appsecret =
      'riXSV1NsPY6G1uoukJaoXC/IKLGd0mLPByAOj2oVtCruAr6o38pmAVR4viJkiiAIWZ+CJPsr1Chuh/HvKnXAaHOGBgBv0ftPsT+hU43BtbXsC4MdPbpAmIlTLmnC0amIvS3FB6Bk+2w3sHJQIK9aEM2H0cI9sfJweuFzuDK3wfTaGfEalf8=';
  final String contentType = 'application/json; charset=utf-8';

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
      'Content-Type': contentType,
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
      debugPrint('getToken_발급 성공');
      return jsonResponse['access_token'];
    } else {
      debugPrint(
          'getToken_발급 실패 : ${response.statusCode}, response : ${response.body}');
      return null;
    }
  }

  // 주식당일분봉조회 -> 개별주식
  Future<List<StockMinData>> getMinData(accessToken) async {
    const path =
        'uapi/domestic-stock/v1/quotations/inquire-time-itemchartprice';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'content-type': contentType,
      'authorization': 'Bearer $accessToken',
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
          if (!resultList.any((data) => data.time == stockData.time)) {
            resultList.add(stockData);
          }
        }

        // 변경된 부분: 정렬할 리스트에 데이터 추가
        // resultList.addAll(filteredData);
      } else {
        throw Exception('Failed to load stock data');
      }
    }

    debugPrint('모델 생성 성공');

    // 변경된 부분: 시간 순으로 정렬
    resultList.sort((a, b) => a.time.compareTo(b.time));
    for (int i = 0; i < resultList.length; i++) {
      debugPrint('time : ${resultList[i].time}');
      debugPrint('price : ${resultList[i].price}');
    }

    return resultList;
  }

  // 주식현재가 시세 -> 개별주식
  Future<StockDataModel> getStockData(accessToken, code) async {
    const path = 'uapi/domestic-stock/v1/quotations/inquire-price';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'authorization': 'Bearer $accessToken',
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
        debugPrint('getStockData_응답 성공');
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
      'content-type': contentType,
      'authorization': 'Bearer $accessToken',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHPUP02100000',
      'custtype': 'P',
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
        debugPrint('getMajorIndex_응답 성공');
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

  // 순위 분석 - 거래량 순위
  Future<List<VolumeRankingModel>?> getVolumeRanking(accessToken) async {
    const path = 'uapi/domestic-stock/v1/quotations/volume-rank';
    final url = Uri.parse('$baseUrl/$path');

    // 요청 헤더 설정
    final headers = {
      'Content-Type': contentType,
      'authorization': 'Bearer $accessToken',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHPST01710000',
      'custtype': 'P',
    };

    final params = {
      // 업종 'U'
      'FID_COND_MRKT_DIV_CODE': 'J',
      'FID_COND_SCR_DIV_CODE': '20171',
      // 0000(전체) 기타(업종코드)
      'FID_INPUT_ISCD': '0000',
      // 0(전체) 1(보통주) 2(우선주)
      'FID_DIV_CLS_CODE': '0',
      // 0 : 평균거래량 1:거래증가율 2:평균거래회전율 3:거래금액순 4:평균거래금액회전율
      'FID_BLNG_CLS_CODE': '0',
      // 1 or 0 9자리 (차례대로 증거금 30% 40% 50% 60% 100% 신용보증금 30% 40% 50% 60%)
      'FID_TRGT_CLS_CODE': '111111111',
      // 1 or 0 10자리 (차례대로 투자위험/경고/주의 관리종목 정리매매 불성실공시 우선주 거래정지 ETF ETN 신용주문불가 SPAC)
      'FID_TRGT_EXLS_CLS_CODE': '0000011100',
      // 가격 ~ ex) "0"
      // 전체 가격 대상 조회 시 FID_INPUT_PRICE_1, FID_INPUT_PRICE_2 모두 ""(공란) 입력
      'FID_INPUT_PRICE_1': '',
      'FID_INPUT_PRICE_2': '',
      // 거래량 ~ // ex) "100000"
      // 전체 거래량 대상 조회 시 FID_VOL_CNT ""(공란) 입력
      'FID_VOL_CNT': '',
      'FID_INPUT_DATE_1': '',
    };

    final response = await http.get(
      url.replace(
        queryParameters: params,
      ),
      headers: headers,
    );

    // debugPrint('status : ${response.statusCode}');
    // debugPrint('response : ${response.body}');

    try {
      if (response.statusCode == 200) {
        // 리스트 형태
        final decodeData = jsonDecode(response.body);
        // debugPrint('decodeData : $decodeData');
        // 데이터 추출
        final List<dynamic> data = decodeData['output'];
        // debugPrint('data : $data');

        // 리스트 데이터를 VolumeRankingModel로 변환
        final list = data
            .map((item) => VolumeRankingModel.fromJson(
                item as Map<String, dynamic>)) // 변경된 부분
            .toList();
        debugPrint('getVolumeRanking_응답 성공');
        // int i = 0;
        // debugPrint('순위 : ${list[i].rank}');
        // debugPrint('이름 : ${list[i].korName}');
        // debugPrint('가격 : ${list[i].price}');
        // debugPrint('전일 대비 가격 변화량 : ${list[i].changePrice}');
        // debugPrint('전일 대비 가격 변화율 : ${list[i].changePriceRate}');
        // debugPrint('평균 거래량 : ${list[i].volAvg}');
        // debugPrint('거래량 증가율 : ${list[i].volIncRate}');
        // debugPrint('평균 거래 대금 : ${list[i].priceAvg}');

        return list;
      } else {
        throw Exception('getVolumeRanking_응답 실패 ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getVolumeRanking_에러: $e');
    }
  }

  // 순위 분석 - 등락률 순위
  Future<List<ChangeRateRankingModel>?> getChangeRateRanking(
      accessToken, sort) async {
    const path = 'uapi/domestic-stock/v1/ranking/fluctuation';
    final url = Uri.parse('$baseUrl/$path');

    // 요청 헤더 설정
    final headers = {
      'content-type': contentType,
      'authorization': 'Bearer $accessToken',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHPST01700000',
      'custtype': 'P',
    };

    final params = {
      'fid_rsfl_rate2': '',
      // 업종 'U'
      'fid_cond_mrkt_div_code': 'J',
      'fid_cond_scr_div_code': '20170',
      // 0000(전체) 코스피(0001), 코스닥(1001), 코스피200(2001)
      'fid_input_iscd': '0000',
      // 0:상승율순 1:하락율순 2:시가대비상승율 3:시가대비하락율 4:변동율
      'fid_rank_sort_cls_code': sort,
      // 0:전체 , 누적일수 입력
      'fid_input_cnt_1': '0',
      // 상승율 순일때 (0:저가대비, 1:종가대비)
      // 하락율 순일때 (0:고가대비, 1:종가대비)
      // 기타 (0:전체)
      'fid_prc_cls_code': '1',
      // 입력 가격 ( price 1 ~ 2 )
      'fid_input_price_1': '',
      'fid_input_price_2': '',
      // 거래량 수
      'fid_vol_cnt': '',
      'fid_trgt_cls_code': '0',
      'fid_trgt_exls_cls_code': '0',
      'fid_div_cls_code': '0',
      'fid_rsfl_rate1': '',
    };

    final response = await http.get(
      url.replace(
        queryParameters: params,
      ),
      headers: headers,
    );

    // debugPrint('status : ${response.statusCode}');
    // debugPrint('response : ${response.body}');

    try {
      if (response.statusCode == 200) {
        // 리스트 형태
        final decodeData = jsonDecode(response.body);
        // debugPrint('decodeData : $decodeData');
        // 데이터 추출
        final List<dynamic> data = decodeData['output'];
        // debugPrint('data : $data');

        // 리스트 데이터를 VolumeRankingModel로 변환
        final list = data
            .map((item) => ChangeRateRankingModel.fromJson(
                item as Map<String, dynamic>)) // 변경된 부분
            .toList();
        debugPrint('getChangeRateRanking_응답 성공');

        return list;
      } else {
        throw Exception('getChangeRateRanking_응답 실패 ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getChangeRateRanking_에러: $e');
    }
  }

  // 순위 분석 - 시가 총액 상위
  Future<List<MarketCapRankingModel>?> getMarketCapRanking(accessToken) async {
    const path = 'uapi/domestic-stock/v1/ranking/market-cap';
    final url = Uri.parse('$baseUrl/$path');

    // 요청 헤더 설정
    final headers = {
      'content-type': contentType,
      'authorization': 'Bearer $accessToken',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHPST01740000',
      'custtype': 'P',
    };

    final params = {
      // 업종 'U' 주식 'J'
      'fid_cond_mrkt_div_code': 'J',
      'fid_cond_scr_div_code': '20174',
      // 0: 전체, 1:보통주, 2:우선주
      'fid_div_cls_code': '0',
      // 0000:전체, 0001:거래소, 1001:코스닥, 2001:코스피200
      'fid_input_iscd': '0000',
      'fid_trgt_cls_code': '0',
      'fid_trgt_exls_cls_code': '0',
      // 입력 가격 ( price 1 ~ 2 )
      'fid_input_price_1': '',
      'fid_input_price_2': '',
      // 거래량 수
      'fid_vol_cnt': '',
    };

    final response = await http.get(
      url.replace(
        queryParameters: params,
      ),
      headers: headers,
    );

    // debugPrint('status : ${response.statusCode}');
    // debugPrint('response : ${response.body}');

    try {
      if (response.statusCode == 200) {
        // 리스트 형태
        final decodeData = jsonDecode(response.body);
        // debugPrint('decodeData : $decodeData');
        // 데이터 추출
        final List<dynamic> data = decodeData['output'];
        // debugPrint('data : $data');

        // 리스트 데이터를 VolumeRankingModel로 변환
        final list = data
            .map((item) => MarketCapRankingModel.fromJson(
                item as Map<String, dynamic>)) // 변경된 부분
            .toList();
        debugPrint('getMarketCapRanking_응답 성공');

        return list;
      } else {
        throw Exception('getMarketCapRanking_응답 실패 ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getMarketCapRanking_에러: $e');
    }
  }

  // 해외주식 종목/지수/환율기간별시세
  Future<ForeignMajorIndexModel> getForeignMajorIndex(accessToken, code, type) async {
    const path = 'uapi/overseas-price/v1/quotations/inquire-daily-chartprice';
    final url = Uri.parse('$baseUrl/$path');

    final headers = {
      'content-type': contentType,
      'authorization': 'Bearer $accessToken',
      'appKey': appkey,
      'appSecret': appsecret,
      'tr_id': 'FHKST03030100',
    };

    final params = {
      // N: 해외지수, X 환율, I: 국채, S:금선물
      'FID_COND_MRKT_DIV_CODE': type,
      'FID_INPUT_ISCD': code,
      'FID_INPUT_DATE_1': '20241120',
      'FID_INPUT_DATE_2': '20241121',
      'FID_PERIOD_DIV_CODE': 'D',
    };

    final response = await http.get(
      url.replace(
        queryParameters: params,
      ),
      headers: headers,
    );

    // debugPrint('status : ${response.statusCode}');
    // debugPrint('response : ${response.body}');

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // 데이터 추출
        final stockData = data['output1'];
        final result = ForeignMajorIndexModel.fromJson(stockData);

        debugPrint('getForeignMajorIndex_응답 성공');
        return result;
      } else {
        throw Exception('getForeignMajorIndex_응답 실패 ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('getForeignMajorIndex_에러: $e');
    }
  }



}
