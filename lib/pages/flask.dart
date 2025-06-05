import 'dart:convert';
import 'package:http/http.dart' as http;

class FlaskAPI {
  static const String _url = 'https://toptop-lsq0.onrender.com/ask';

  static Future<Map<String, dynamic>> fetchToptopAnswer(String question) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'question': question}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'answer': data['answer'] ?? '탑탑이가 아직 컨디션이 안 좋아서 대답을 못 했어요…',
          'image': data['image']
        };
      } else {
        return {
          'answer': '탑탑이 몸 상태가 안 좋아서 잠깐 쉬고 있어요… (${response.statusCode})',
          'image': null
        };
      }
    } catch (e) {
      return {
        'answer': '탑탑이가 지금 연결이 안 돼요… 회복 중이에요, 조금만 기다려 주세요 !',
        'image': null
      };
    }
  }
}