import 'package:eiviznho/app/data/repositories/api/alert_api_repository_impl.dart';
import 'package:eiviznho/app/domain/repositories/alert_repository.dart';
import 'package:eiviznho/app/domain/usecases/get_alerts_usecases.dart';
import 'package:get_it/get_it.dart';

GetIt alertListInject = GetIt.instance;

void setupAlertListInject() {
  alertListInject
      .registerLazySingleton<AlertRepository>(() => AlertRepositoryImp());

  alertListInject.registerLazySingleton<GetAlertsUsecases>(
      () => GetAlertsUsecases(alertListInject.get<AlertRepository>()));
}
