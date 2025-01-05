import 'dart:convert';

import 'package:eiviznho/app/data/repositories/alert_category/alert_category_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AlertTypeRepositoryImpl implements AlertCategoryRepository {
  @override
  Future<List<AlertCategory>> getAllAlertType() async {
    final String? url = dotenv.env['BASE_URL'];
    final response = await http.get(Uri.parse('$url/alert_category'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;

      final List<AlertCategory> alerts =
          body.map((alert) => AlertCategory.fromJson(alert)).toList();
      return alerts;
    }

    return [];
  }
}
