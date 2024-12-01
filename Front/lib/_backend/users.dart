import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  // 서버 URL -> 로컬
  final String baseUrl = 'http://192.168.0.194:8080/api/users';

  // 회원가입 메소드
  Future<String> registerUser(String userId, String password, String email) async {
    final url = Uri.parse('$baseUrl/register'); // 회원가입 경로
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      // 'id': id,
      'userId': userId,
      'password': password,
      'email': email,
    });

    try {
      // POST 요청 전송
      final response = await http.post(url, headers: headers, body: body);

      print('응답 상태 코드: ${response.statusCode}');
      print('응답 본문: ${response.body}');

      if (response.statusCode == 201) {
        // 회원가입 성공
        return '회원가입 성공!';
      } else {
        // 실패 시 서버에서 반환한 메시지
        final Map<String, dynamic> responseBody = json.decode(response.body);
        return responseBody['message'] ?? '회원가입 실패';
      }
    } catch (e) {
      // 네트워크 또는 기타 오류 처리
      return '오류 발생: $e';
    }
  }
}