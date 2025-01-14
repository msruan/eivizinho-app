class AlertCategory {
  final String id;
  final String name;
  final double gravity;
  final String description;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  AlertCategory({
    required this.id,
    required this.name,
    required this.gravity,
    required this.description,
    // required this.createdAt,
    // required this.updatedAt
  });

  AlertCategory.fromJson(Map<String, dynamic> json)
      : id = (json['id'] as int).toString(),
        name = json['name'] as String,
        gravity = json['gravity'] as double,
        description = json['description'] as String
  // createdAt = DateTime.parse(json['created_at'] as String),
  // updatedAt = DateTime.parse(json['updated_at'] as String)
  ;
}
