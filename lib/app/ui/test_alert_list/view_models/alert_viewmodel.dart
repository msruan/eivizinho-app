import 'package:eiviznho/app/data/repositories/alert/alert_api_repository_impl.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:flutter/foundation.dart';

class AlertViewModel extends ChangeNotifier {
  List<AlertEntity>? _alerts;

  List<AlertEntity>? get alerts => _alerts;

  Future<void> fetchAlerts() async {
    final alerts = await AlertRepositoryImpl().getAllAlerts();
    _alerts = alerts;

    notifyListeners();
  }
}
