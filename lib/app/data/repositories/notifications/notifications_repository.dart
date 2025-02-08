import 'package:eiviznho/app/domain/entities/notification_entity.dart';

abstract class NotificationsRepository {
  Future<void> initDb();

  Future<void> saveNotification(AppNotification notification);

  Future<List<AppNotification>> getAllNotifications();
}
