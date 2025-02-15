// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:eiviznho/app/domain/entities/user_entity.dart';

class Alert {
  final String id;
  final AlertCategory category;
  final String description;
  final Location local;
  final List<Media> media;
  final DateTime dtHr;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  Alert(
      {required this.id,
      required this.category,
      required this.description,
      required this.dtHr,
      required this.local,
      required this.createdAt,
      required this.updatedAt,
      required this.media,
      required this.user});
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

enum MediaType { image, video, audio }

MediaType strToMediaType(String type) {
  if (type == "image") return MediaType.image;
  if (type == "video") return MediaType.video;
  if (type == "audio") return MediaType.audio;
  throw Exception(
      "Bad params! A non allowed type was passed to strToMediaType function!");
}

class Media {
  int id;
  String url;
  MediaType type;

  Media({required this.id, required this.url, required this.type});

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
        id: map['id'] as int,
        url: map['url'] as String,
        type: strToMediaType(map['type'] as String));
  }
}
