import '../../../domain/entities/alert_entity.dart';

abstract class AlertRepository {
  Future<List<Alert>> getAllAlerts();
  Future<Alert> createAlert(Map<String, dynamic> body);
}
