class AlertType {
  final String id;
  final String name;

  AlertType({
    required this.id,
    required this.name,
  });

  AlertType.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
