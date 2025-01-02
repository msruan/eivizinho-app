class AlertCategory {
  final String id;
  final String name;

  AlertCategory({
    required this.id,
    required this.name,
  });

  AlertCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
