import 'dart:convert';
import 'dart:io';

import 'package:eiviznho/app/config/env.dart';
import 'package:eiviznho/app/config/exceptions.dart';
import 'package:eiviznho/app/config/token_storage.dart';
import 'package:eiviznho/app/data/dtos/auth/login_dto.dart';
import 'package:eiviznho/app/data/dtos/auth/register_dto.dart';
import 'package:eiviznho/app/domain/entities/user_entity.dart';
import 'package:eiviznho/app/utils/debug.dart';
import 'package:http/http.dart' as http;

class AuthAPI {
  static final String? _baseUrl = Enviroment.baseUrl();

  static Future<User> registerUser(
      {required RegisterRequestDTO payload}) async {
    final url = Uri.parse('$_baseUrl/auth/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: payload.toJson(),
      );

      debug(response);

      if (response.statusCode == 201) {
        return RegisterResponseDTO.fromJson(response.body).user;
      } else {
        throw HttpException(
          'Erro no registro: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Erro na requisição de registro: $e');
    }
  }

  static Future<User> login({required LoginRequestDTO payload}) async {
    final String? baseUrl = Enviroment.baseUrl();

    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: payload.toJson(),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (!(responseBody is Map<String, dynamic> &&
          responseBody.containsKey('token'))) {
        throw APIException("Unacceptable body received from backend!",
            code: 666);
      }
      final dto = LoginResponseDTO.fromMap(responseBody);
      final token = dto.token;
      await TokenStorage.storeToken(token);
      return dto.user;
    } else {
      throw APIException(response.body, code: response.statusCode);
    }
  }
}
