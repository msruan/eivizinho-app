import 'dart:convert';
import 'dart:io';

import 'package:eiviznho/app/config/token_storage.dart';
import 'package:eiviznho/app/config/env.dart';
import 'package:eiviznho/app/config/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AlertAPI {
  static final String? baseUrl = Enviroment.baseUrl();

  static Future<http.Response> getAlerts() async {
    late http.Response response;

    try {
      final url = Uri.parse('$baseUrl/alerts');
      response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
    } catch (e) {
      throw InternetException('Erro em  AlertAPI getAlerts: $e');
    }

    if (response.statusCode == 200) {
      return response;
    } else {
      throw HttpException('Falha ao obter alertas: ${response.statusCode}');
    }
  }

  static Future<http.Response> postAlertAsJson(
      Map<String, dynamic> body) async {
    final token = await TokenStorage.getToken();
    final url = Uri.parse('$baseUrl/alerts');
    try {
      body["categoriesId"] = body["categoriesId"].toString();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 201) {
        return response;
      } else {
        throw HttpException(
            'Falha ao criar alerta: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw InternetException('Erro POST JSON Alerta: $e');
    }
  }

  static Future<http.StreamedResponse> postAlertAsMultipart(
      Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/alerts');
    final token = await TokenStorage.getToken();
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'name': body['name'],
      'categoriesId': jsonEncode(body['categoriesId']),
      'approximateDtHr': body['approximateDtHr'],
      'location': body['location'],
    });

    for (var mediaPath in body['media']) {
      var file = await http.MultipartFile.fromPath(
        'media',
        mediaPath,
        contentType: MediaType('image', 'jpg'),
      );
      request.files.add(file);
    }

    request.headers.addAll({'Authorization': 'Bearer $token'});

    try {
      final streamedResponse = await request.send();
      // final response = await http.Response.fromStream(streamedResponse);

      if (streamedResponse.statusCode == 201) {
        return streamedResponse;
      } else {
        throw Exception(
            'Falha ao criar alerta com mídia: ${streamedResponse.statusCode} ${streamedResponse.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erro POST MULTIPART Alerta: $e');
    }
  }
}
