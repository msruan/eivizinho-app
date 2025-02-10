import 'package:eiviznho/app/data/repositories/alert_category/alert_category_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';

class FakeAlertCategoryRepository implements AlertCategoryRepository {
  final List<AlertCategory> _categories = [
    AlertCategory(id: "1", name: "Furto", gravity: 0.1, description: "Crime"),
    AlertCategory(
        id: "2", name: "Acidente", gravity: 0.2, description: "Ambiental"),
  ];

  @override
  Future<List<AlertCategory>> getAllAlertType() async {
    return Future.value(_categories);
  }
}
