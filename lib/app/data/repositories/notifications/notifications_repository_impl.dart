import 'package:eiviznho/app/data/repositories/notifications/notifications_repository.dart';
import 'package:eiviznho/app/domain/entities/notification_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  late Database _database;

  NotificationsRepositoryImpl() {
    initDb();
  }

  @override
  Future<void> initDb() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'notification.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE notifications(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            category TEXT,
            date TEXT
          )
        ''');
      },
    );
  }

  @override
  Future<List<AppNotification>> getAllNotifications() async {
    final List<Map<String, dynamic>> maps =
        await _database.query('notifications');

    print('cade $maps');

    return List.generate(maps.length, (i) {
      return AppNotification(
        id: maps[i]['id'],
        name: maps[i]['name'],
        date: DateTime.parse(maps[i]['date']),
        category: maps[i]['category'],
      );
    });
  }

  @override
  Future<void> saveNotification(AppNotification notification) {
    print("Saving notification: $notification");

    return _database.insert(
      'notifications',
      notification.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
