import 'package:eiviznho/app/data/repositories/alert_type/alert_type_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_type_entity.dart';

class AlertTypeRepositoryImpl implements AlertTypeRepository {
  @override
  Future<List<AlertType>> getAllAlertType() async {
    return [
      AlertType(id: '1', name: 'Acidente'),
      AlertType(id: '2', name: 'Assalto'),
      AlertType(id: '3', name: 'Incendio')
    ];
  }
}
