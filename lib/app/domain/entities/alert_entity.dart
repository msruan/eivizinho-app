class AlertEntity {
  final String id;
  final String type;
  final String description;
  final DateTime dtHr;
  final String local;
  // final User user;

  AlertEntity({
    required this.id,
    required this.type,
    required this.description,
    required this.dtHr,
    required this.local,
    // required this.user,
  });

  AlertEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        type = json['type'] as String,
        description = json['description'] as String,
        dtHr = DateTime.parse(json['dtHr'] as String),
        local = json['local'] as String;
  // user = User.fromJson(json['user'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'dtHr': dtHr.toIso8601String(),
      'local': local,
      // 'user': user.toJson();
    };
  }
}
