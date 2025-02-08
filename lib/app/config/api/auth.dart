import 'dart:convert';
import 'dart:io';

import 'package:eiviznho/app/config/env.dart';
import 'package:eiviznho/app/utils/debug.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  static final String? _baseUrl = Enviroment.baseUrl();

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

      debug(response);

      if (response.statusCode == 201) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw HttpException(
          'Erro no registro: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Erro na requisição de registro: $e');
    }
  }
}
