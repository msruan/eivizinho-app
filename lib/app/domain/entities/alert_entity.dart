// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';

class Alert {
  final String id;
  final AlertCategory category;
  final String description;
  final Location local;
  final List<Media> media;
  final DateTime dtHr;
  final DateTime createdAt;
  final DateTime updatedAt;

  Alert(
      {required this.id,
      required this.category,
      required this.description,
      required this.dtHr,
      required this.local,
      required this.createdAt,
      required this.updatedAt,
      required this.media});
}

class Location {
  final String? description;
  final double latitude;
  final double longitude;

  Location({
    this.description,
    required this.latitude,
    required this.longitude,
  });

  Location.fromJson(Map<String, dynamic> json)
      : description = json['description'] as String?,
        latitude = (json['coord']['latitude'] as num).toDouble(),
        longitude = (json['coord']['longitude'] as num).toDouble();

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'coord': {
        'latitude': latitude,
        'longitude': longitude,
      },
    };
  }
}

class Media {
  int id;
  String url;
  Media({
    required this.id,
    required this.url,
  });

  // factory Media.fromMap(Map<String, dynamic> map) {
  //   return Media(
  //     id: map['id'] as int,
  //     url: map['url'] as String,
  //   );
  // }
}
