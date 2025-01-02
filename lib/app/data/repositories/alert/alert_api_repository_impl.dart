import 'dart:convert';

import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:http/http.dart' as http;

class AlertRepositoryImp implements AlertRepository {
  @override
  Future<List<AlertEntity>> getAllAlerts() async {
    final response = await http.get(Uri.parse('http://localhost:3000/alert'));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<dynamic>;

      final List<AlertEntity> alerts =
          body.map((alert) => AlertEntity.fromJson(alert)).toList();
      print('OBA LA VEM ELA');
      return alerts;
    }

    return [];
  }

  @override
  Future<AlertEntity> createAlert() async {
    return AlertEntity(
      type: "Furto",
      description: "Crime ocorreu por volta das 15hrs",
      id: '17',
      dtHr: DateTime.now(),
      local: 'Ininga',
    );
  }
}
