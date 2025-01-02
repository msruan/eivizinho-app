import 'package:eiviznho/app/domain/entities/alert_type_entity.dart';

abstract class AlertTypeRepository {
  Future<List<AlertType>> getAllAlertType();
  // Future<AlertType> createAlert();
}
