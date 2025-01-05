import 'package:image_picker/image_picker.dart';

class Alert {
  final String category;
  final String description;
  final DateTime dtHr;
  final String local;
  final List<XFile>? media;

  Alert(
      {required this.category,
      required this.description,
      required this.dtHr,
      required this.local,
      this.media});

  Alert.fromJson(Map<String, dynamic> json)
      : category = json['category'] as String,
        description = json['description'] as String,
        dtHr = DateTime.parse(json['dtHr'] as String),
        local = json['local'] as String,
        media = (json['media'] as List?)
                ?.map((e) => XFile(e.toString()))
                .toList() ??
            [];

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'dtHr': dtHr.toIso8601String(),
      'local': local,
      'media': media?.map((mediaFile) => mediaFile.path).toList() ?? []
    };
  }
}
