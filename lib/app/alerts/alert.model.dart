import 'package:flutter/material.dart';

class Alert {
  late String type;
  late String description;

  Alert(this.type, this.description);

  Alert.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String,
        description = json['email'] as String;

  Map<String, dynamic> toJson() => {
        'type': type,
        'description': description,
      };
}
