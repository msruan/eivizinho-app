import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/domain/repositories/alert_repository.dart';

class GetAlertsUsecases {
  AlertRepository alertRepository;

  GetAlertsUsecases(this.alertRepository);

  Future<List<AlertEntity>> execute() {
    return alertRepository.getAllAlerts();
  }
}
