class AppNotification {
  int? id;
  final String name;
  final String category;
  final DateTime date;

  AppNotification({
    this.id,
    required this.name,
    required this.category,
    required this.date,
  });

  AppNotification.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        category = json['category'] as String,
        date = DateTime.parse(json['date'] as String);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'date': date.toIso8601String(),
    };
  }
}
