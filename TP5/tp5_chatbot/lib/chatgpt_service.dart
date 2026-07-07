import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGptService {
  // TODO: replace with your own OpenAI API key before running.
  // Never commit a real key to git - keep this as a placeholder.
  static const String _apiKey = 'YOUR_OPENAI_API_KEY';
  static const String _endpoint = 'https://api.openai.com/v1/chat/completions';

  static Future<String> ask(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'user', 'content': prompt},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return (data['choices'][0]['message']['content'] as String).trim();
      }
      return 'Erreur serveur (${response.statusCode}). Vérifiez votre clé API.';
    } catch (e) {
      return 'Erreur réseau : $e';
    }
  }
}
