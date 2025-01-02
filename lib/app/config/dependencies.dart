import 'package:eiviznho/app/data/repositories/alert/alert_api_repository_impl.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/data/repositories/alert_category/alert_category_api_repository_impl.dart';
import 'package:eiviznho/app/data/repositories/alert_category/alert_category_repository.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

void setupGetItInject() {
  injector.registerLazySingleton<AlertRepository>(() => AlertRepositoryImpl());

  injector.registerLazySingleton<AlertCategoryRepository>(
      () => AlertTypeRepositoryImpl());
}
