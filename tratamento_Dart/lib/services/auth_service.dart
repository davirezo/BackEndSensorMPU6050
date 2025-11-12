import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiKey = 'AIzaSyDR_udQ5-a7uu1k23U_MGCio_cxQAPL4W0';

  Future<String?> autenticarComEmailSenha({
    required String email,
    required String senha,
  }) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': senha,
          'returnSecureToken': true,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('✅ Autenticação bem-sucedida!');
        return data['idToken'];
      } else {
        print('❌ Erro na autenticação: ${response.statusCode}');
        print('Detalhes: ${response.body}');
        return null;
      }
    } catch (e) {
      print('⚠️ Erro de conexão: $e');
      return null;
    }
  }
}