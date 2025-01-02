import 'package:eiviznho/app/data/repositories/alert_type/alert_type_api_repository_impl.dart';
import 'package:eiviznho/app/data/repositories/alert_type/alert_type_repository.dart';
import 'package:get_it/get_it.dart';

GetIt alertTypeInject = GetIt.instance;

void setupAlertTypeInject() {
  alertTypeInject.registerLazySingleton<AlertTypeRepository>(
      () => AlertTypeRepositoryImpl());
}