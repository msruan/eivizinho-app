import 'package:eiviznho/app/data/dtos/alerts/create_alert_dto.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';

import '../models/user.dart';

class FakeAlertRepository implements AlertRepository {
  final List<Alert> _alerts = [];
  @override
  Future<List<Alert>> getAllAlerts() async {
    return Future.value(_alerts);
  }

  @override
  Future<Alert> createAlert(CreateAlertRequestDTO body) async {
    final newAlert = Alert(
        id: (_alerts.length + 1).toString(),
        category: body.categories[0],
        description: body.name,
        dtHr: DateTime.now(),
        local: body.location,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        media: [],
        user: user);

    return Future.value(newAlert);
  }
}
