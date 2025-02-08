import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  static final String? _baseUrl = dotenv.env['BASE_URL'];

  static Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String cpf,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'cpf': cpf,
          'email': email,
          'password': password,
          'passwordConfirmation': passwordConfirmation,
        }),
      );

      print(response);

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception(
          'Erro no registro: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Erro na requisição de registro: $e');
    }
  }
}
