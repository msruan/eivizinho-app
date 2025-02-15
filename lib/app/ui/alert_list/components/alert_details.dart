import 'dart:async';

import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/alert_page/alert_screen.dart';
import 'package:eiviznho/app/ui/themes/alert_categories.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class AlertDetails extends StatelessWidget {
  final Alert alert;
  AlertDetails({super.key, required this.alert});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final categorieTheme = AlertCategoriesTheme.getByName(alert.category.name);
    final icon = categorieTheme.icon;
    final date = DateFormat('dd/MM/yyyy').format(alert.dtHr);
    final time = DateFormat('HH:mm').format(alert.dtHr);

    return Dialog(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.close,
                  ),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18, left: 22, right: 22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlertPageScreen(
                          alert: alert,
                        ), // O widget que você deseja empurrar
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        spacing: 18,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey.withAlpha(15),
                              child: Icon(icon,
                                  color: AppColors.textPrimary, size: 18),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.category.name,
                                style: AppTextStyles.titleExtraSmall,
                                textAlign: TextAlign.left,
                              ),
                              Text('$time • $date')
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        alert.description,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 102,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        alert.local.latitude,
                        alert.local.longitude,
                      ),
                      zoom: 14.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId("Alert position"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            categorieTheme.bitMapHue),
                        position:
                            LatLng(alert.local.latitude, alert.local.longitude),
                      )
                    },
                    onMapCreated: (GoogleMapController control) {
                      _controller.complete(control);
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Relatado por ${alert.user.name}',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
