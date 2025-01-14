import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AlertAPI {
  static final String? baseUrl = dotenv.env['BASE_URL'];

  static Future<http.Response> getAlerts() async {
    final url = Uri.parse('$baseUrl/alerts');
    try {
      final response =
          await http.get(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Falha ao obter alertas: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro GET Alerta: $e');
    }
  }

  static Future<http.Response> postAlertAsJson(
      Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/alerts');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Falha ao criar alerta: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro POST JSON Alerta: $e');
    }
  }

  static Future<http.StreamedResponse> postAlertAsMultipart(
      Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/alert');
    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'category': body['category'],
      'description': body['description'],
      'dtHr': body['dtHr'],
      'local': body['local'],
    });

    for (var mediaPath in body['media']) {
      var file = await http.MultipartFile.fromPath(
        'media',
        mediaPath,
        contentType: MediaType('image', 'jpg'),
      );
      request.files.add(file);
    }

    try {
      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 201) {
        return streamedResponse;
      } else {
        throw Exception(
            'Falha ao criar alerta com mídia: ${streamedResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro POST MULTIPART Alerta: $e');
    }
  }
}
