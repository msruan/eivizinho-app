import 'package:eiviznho/app/data/repositories/alert_category/alert_category_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';

class AlertTypeRepositoryImpl implements AlertCategoryRepository {
  @override
  Future<List<AlertCategory>> getAllAlertType() async {
    return [
      AlertCategory(id: '1', name: 'Acidente'),
      AlertCategory(id: '2', name: 'Assalto'),
      AlertCategory(id: '3', name: 'Incendio')
    ];
  }
}
