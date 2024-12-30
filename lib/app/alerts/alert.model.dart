import 'package:eiviznho/app/user/user.model.dart';

class Alert {
  late String type;
  late String description;
  late String id;
  late DateTime dt_hr;
  late String local;
  late User user;

  Alert(this.type, this.description, this.dt_hr, this.local);

  Alert.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String,
        id = json['id'] as String,
        description = json['description'] as String,
        dt_hr = json['dt_hr'],
        local = json['local'] as String;

  Map<String, dynamic> toJson() =>
      {'type': type, 'description': description, 'id': id};
}
