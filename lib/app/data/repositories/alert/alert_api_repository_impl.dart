import 'dart:convert';

import 'package:eiviznho/app/config/api/alert.dart';
import 'package:eiviznho/app/data/dtos/alerts/create_alert_dto.dart';
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
  Future<Alert> createAlert(CreateAlertRequestDTO body) async {
    late String responseBody;

    final payload = body.toJson();

    if (body.media == null || body.media!.isEmpty) {
      final response = await AlertAPI.postAlertAsJson(payload);
      responseBody = response.body;
    } else {
      final response = await AlertAPI.postAlertAsMultipart(payload);
      responseBody = await response.stream.bytesToString();
    }

    final Map<String, dynamic> data = jsonDecode(responseBody);
    return Alert.fromJson(data);
  }
}
