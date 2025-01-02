import '../../../domain/entities/alert_entity.dart';

abstract class AlertRepository {
  Future<List<AlertEntity>> getAllAlerts();
  Future<AlertEntity> createAlert();
}
