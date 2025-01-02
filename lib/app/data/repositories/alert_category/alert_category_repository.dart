import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';

abstract class AlertCategoryRepository {
  Future<List<AlertCategory>> getAllAlertType();
  // Future<AlertType> createAlert();
}
