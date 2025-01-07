import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:image_picker/image_picker.dart';

class Alert {
  final String id;
  final AlertCategory category;
  final String description;
  final DateTime dtHr;
  final Location local;
  final List<XFile>? media;

  Alert(
      {required this.id,
      required this.category,
      required this.description,
      required this.dtHr,
      required this.local,
      this.media});

  Alert.fromJson(Map<String, dynamic> json)
      : id = (json['id'] as double).toString(),
        description = json['name'] as String,
        category = AlertCategory.fromJson((json['categories'] as List)[0]),
        dtHr = DateTime.parse(json['createdAt'] as String),
        local = Location.fromJson(json['location']),
        media = [];

  //TODO: And the remaining fields?
  Map<String, dynamic> toJson() {
    return {
      'name': description,
      'categoriesId': [category.id],
    };
    //  return {
    //   'name': category,
    //   'description': description,
    //   'dtHr': dtHr.toIso8601String(),
    //   'local': local,
    //   'media': media?.map((mediaFile) => mediaFile.path).toList() ?? []
    // };
  }
}

class Location {
  final String? description;
  final double latitude;
  final double longitude;

  Location({this.description, required this.latitude, required this.longitude});

  Location.fromJson(Map<String, dynamic> json)
      : description = json['description'] as String,
        latitude = json['coord']['latitude'] as double,
        longitude = json['coord']['longitude'] as double;

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
