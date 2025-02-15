import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef AlertCategoryTheme = ({
  String name,
  IconData icon,
  Color color,
  double bitMapHue
});

//  final Map<String, double> categoryColors = {
//     'assalto': BitmapDescriptor.hueRed,
//     'incêndio': BitmapDescriptor.hueOrange,
//     'acidente': BitmapDescriptor.hueYellow,
//     'furto': BitmapDescriptor.hueBlue,
//   };

abstract final class AlertCategoriesTheme {
  static final List<AlertCategoryTheme> _alertCategoriesTheme = [
    (
      name: "Assalto",
      color: Colors.pink,
      icon: Icons.no_cell_sharp,
      bitMapHue: BitmapDescriptor.hueRose
    ),
    (
      name: "Incêndio",
      color: Colors.blueGrey,
      icon: Icons.fire_truck,
      bitMapHue: BitmapDescriptor.hueAzure
    ),
  ];

  static AlertCategoryTheme getByName(String name) {
    final AlertCategoryTheme defaultTheme = (
      name: "Padrão",
      color: Colors.pink,
      icon: Icons.warning_amber_rounded,
      bitMapHue: BitmapDescriptor.hueViolet
    );
    return _alertCategoriesTheme
            .firstWhereOrNull((type) => type.name == name) ??
        defaultTheme;
  }

  static Color getGravityColor(double gravity) {
    if (gravity < 0.33) return Colors.yellowAccent;

    if (gravity < 0.66) return Colors.orange;

    return const Color.fromARGB(255, 210, 16, 2);
  }
}
