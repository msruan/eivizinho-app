import 'dart:convert';

import 'package:eiviznho/app/config/api/alert.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';

class AlertRepositoryImpl implements AlertRepository {
  @override
  Future<List<Alert>> getAllAlerts() async {
    final response = await AlertAPI.getAlerts();

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      final List<Alert> alerts =
          body.map((alert) => Alert.fromJson(alert)).toList();

      return alerts;
    }

    return [];
  }

  @override
  Future<Alert> createAlert(Map<String, dynamic> body) async {
    late String responseBody;

    if (body['media'] == null || body['media'].isEmpty) {
      final response = await AlertAPI.postAlertAsJson(body);
      responseBody = response.body;

    } else {
      final response = await AlertAPI.postAlertAsMultipart(body);
      responseBody = await response.stream.bytesToString();
    }

    final Map<String, dynamic> data = jsonDecode(responseBody);
    return Alert.fromJson(data);
  }
}
