// http( pub.dev에 치면 나옴 )
// pubspec.yarm에 있는 http: ^1.2.2
import 'package:http/http.dart' as http;

// jsonDecode 이용
import 'dart:convert';

class KospiService {
  static const String _kospi_url =
      'http://data-dbg.krx.co.kr/svc/apis/idx/kospi_dd_trd';
  static const String _kospi_key = '0D921F9E04B843BBB4798A6B3175BD1D3D7FEAC8';

  // sample 데이터
  // static const String _kospi_url = 'http://data-dbg.krx.co.kr/svc/sample/apis/idx/kospi_dd_trd';
  // static const String _kospi_key = '74D1B99DFBF345BBA3FB4476510A4BED4C78D13A';

  // 사용할 때
  // Future<Map<String, dynamic>> a = KospiService.getKospi();
  // 해서 쓰면 됨
  Future<Map<String, dynamic>> getKospi() async {
    final url = Uri.parse('$_kospi_url?basDd=20200414');
    final headers = {'AUTH_KEY': _kospi_key};
    // print('url : $url');
    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      // 응답 성공
      print('응답 성공');
      // print(response.body);

      // 응답받은 String형태의 response.body -> JSON 변환
      final Map<String, dynamic> kosip = jsonDecode(response.body);
      print(kosip);
      return kosip;
    } else {
      print(response.statusCode);
      print('실패 ...');
    }
    throw Error();
  }
}
