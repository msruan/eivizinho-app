class AlertEntity {
  final String type;
  final String description;
  final String id;
  final DateTime dtHr;
  final String local;
  // final User user;

  AlertEntity({
    required this.type,
    required this.description,
    required this.id,
    required this.dtHr,
    required this.local,
    // required this.user,
  });

  AlertEntity.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String,
        id = json['id'] as String,
        description = json['description'] as String,
        dtHr = DateTime.parse(json['dt_hr'] as String),
        local = json['local'] as String;
  // user = User.fromJson(json['user'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
      'id': id,
      'dt_hr': dtHr.toIso8601String(),
      'local': local,
      // 'user': user.toJson();
    };
  }
}
