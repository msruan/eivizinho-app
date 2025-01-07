import 'package:eiviznho/app/data/dtos/alerts/create_alert_dto.dart';

import '../../../domain/entities/alert_entity.dart';

abstract class AlertRepository {
  Future<List<Alert>> getAllAlerts();
  Future<Alert> createAlert(CreateAlertRequestDTO body);
}
