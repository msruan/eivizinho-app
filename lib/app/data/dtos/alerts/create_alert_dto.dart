// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:eiviznho/app/domain/entities/alert_category_entity.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:image_picker/image_picker.dart';

class CreateAlertRequestDTO {
  final String name;
  final List<AlertCategory> categories;
  final List<XFile>? media;
  final Location location;
  final String approximateDtHr = "2024-06-05T20:00:00";

  CreateAlertRequestDTO({
    required this.name,
    required this.categories,
    required this.location,
    this.media,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'categoriesId':
          categories.map((category) => int.parse(category.id)).toList(),
      'media': media?.map((mediaFile) => mediaFile.path).toList() ?? [],
      'location': '${location.latitude}, ${location.longitude}',
      "approximateDtHr": approximateDtHr
    };
  }
}
