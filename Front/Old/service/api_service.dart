// // http( pub.dev에 치면 나옴 )
// // pubspec.yarm에 있는 http: ^1.2.2
// import 'package:finance/Old/models/kospi.dart';
// import 'package:http/http.dart' as http;
//
// // jsonDecode 이용
// import 'dart:convert';
//
// class KospiService {
//   static const String _kospi_url =
//       'http://data-dbg.krx.co.kr/svc/apis/idx/kospi_dd_trd';
//   static const String _kospi_key = '0D921F9E04B843BBB4798A6B3175BD1D3D7FEAC8';
//
//   // sample 데이터
//   // static const String _kospi_url = 'http://data-dbg.krx.co.kr/svc/sample/apis/idx/kospi_dd_trd';
//   // static const String _kospi_key = '74D1B99DFBF345BBA3FB4476510A4BED4C78D13A';
//
//   static Future<List<KospiModel>> getKospi() async {
//     final url = Uri.parse('$_kospi_url?basDd=20241110');
//     final headers = {'AUTH_KEY': _kospi_key};
//     // print('url : $url');
//     final response = await http.get(
//       url,
//       headers: headers,
//     );
//
//     if (response.statusCode == 200) {
//       print('api_service-KospiService-getKospi : 응답 성공');
//       // print(response.body);
//
//       // 파싱
//       // 응답받은 String형태의 response.body -> JSON 변환
//       final dec = jsonDecode(response.body);
//       // print('dec : $dec');
//
//       // 응답이 맵 형태이므로 'OutBlock_1' 키로 리스트를 가져옴
//       if (dec != null &&
//           dec is Map<String, dynamic> &&
//           dec.containsKey('OutBlock_1')) {
//         List<dynamic> kospiList = dec['OutBlock_1'];
//
//         // 리스트 내의 항목들을 KospiModel로 변환하여 추가
//         List<KospiModel> kospiTemp = [];
//         for (var kospi in kospiList) {
//           final json = KospiModel.fromJson(kospi);
//           kospiTemp.add(json);
//         }
//
//         print('api_service-KospiService-getKospi : json 반환 성공');
//         print(kospiTemp[0]);
//
//         return kospiTemp;
//       } else {
//         print('api_service-KospiService-getKospi : json 반환 실패');
//         print(response.statusCode);
//         return [];
//       }
//     }throw Error();
//   }
// }
//
// //       // 응답받은 String형태의 response.body -> JSON 변환
// //       final Map<String, dynamic> kospi = jsonDecode(response.body);
// //       print(kospi);
// //       return kospi;
// //     } else {
// //       print(response.statusCode);
// //       print('실패 ...');
// //     }
// //     throw Error();
// //   }
// // }
