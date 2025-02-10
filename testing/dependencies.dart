import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/data/repositories/alert_category/alert_category_repository.dart';
import 'package:get_it/get_it.dart';

import 'fakes/repositories/fake_alert_category_repository.dart';
import 'fakes/repositories/fake_alert_repository.dart';

GetIt injector = GetIt.instance;

void setupFakeGetItInject() {
  injector.registerLazySingleton<AlertRepository>(() => FakeAlertRepository());

  injector.registerLazySingleton<AlertCategoryRepository>(
      () => FakeAlertCategoryRepository());
}
