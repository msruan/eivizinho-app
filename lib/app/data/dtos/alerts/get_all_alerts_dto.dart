// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';

abstract final class GetAllAlertsResponseDTO {
  static Alert fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'].toString(),
      category: AlertCategory.fromJson(json['categories'][0]),
      description: json['name'] as String,
      local: Location.fromJson(json['location']),
      dtHr: DateTime.parse(json['approximateDtHr'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      media: (json['media'] as List)
          .map(
            (file) => Media.fromMap(file),
          )
          .toList(),
    );
  }
}
