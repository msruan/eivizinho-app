import 'package:eiviznho/app/data/repositories/alert/alert_api_repository_impl.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:get_it/get_it.dart';

GetIt alertListInject = GetIt.instance;

void setupAlertListInject() {
  alertListInject
      .registerLazySingleton<AlertRepository>(() => AlertRepositoryImpl());
}
