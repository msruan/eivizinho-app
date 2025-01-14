import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:image_picker/image_picker.dart';

class Alert {
  final String id;
  final AlertCategory category;
  final String description;
  final DateTime dtHr;
  final Location local;
  final List<XFile>? media;

  Alert({
    required this.id,
    required this.category,
    required this.description,
    required this.dtHr,
    required this.local,
    this.media,
  });

  Alert.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        description = json['name'] as String,
        category = (json['categories'] as List).isNotEmpty
            ? AlertCategory.fromJson(json['categories'][0])
            : throw Exception('Categoria não encontrada...'),
        dtHr = DateTime.parse(json['createdAt'] as String),
        local = Location.fromJson(json['location']),
        media = json['media'] != null
            ? (json['media'] as List)
                .map((mediaItem) => XFile(mediaItem as String))
                .toList()
            : [];

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': description,
      'categoriesId': [category.id],
      // 'createdAt': dtHr.toIso8601String(),
      // 'location': local.toJson(),
      // 'media': media?.map((mediaFile) => mediaFile.path).toList(),
    };
  }
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
