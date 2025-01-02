import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:flutter/foundation.dart';

class TaskProvider with ChangeNotifier {
  List<AlertEntity> _alerts = [];

  List<AlertEntity> get alerts {
    return [..._alerts];
  }

  void addTask(AlertEntity alert) {
    _alerts.add(alert);
    notifyListeners();
  }

  // Implement methods to update and delete tasks

  // You can also add methods for fetching and managing tasks
}
