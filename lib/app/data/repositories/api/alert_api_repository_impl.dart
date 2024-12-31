import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/domain/repositories/alert_repository.dart';
import 'package:eiviznho/app/mocks.dart';

class AlertRepositoryImp implements AlertRepository {
  @override
  Future<List<AlertEntity>> getAllAlerts() async {
    return mockAlerts;
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
