import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class AlertPageInterface extends StatelessWidget {
  final Alert alert;
  final Completer<GoogleMapController> controller;
  const AlertPageInterface(
      {super.key, required this.alert, required this.controller});

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> alertIcons = {
      'Arrombamento': Icons.lock,
      'Incêndio': Icons.local_fire_department_rounded,
      'Acidente': Icons.local_hospital,
      'Assalto': Icons.warning_rounded,
    };

    final media = alert.media.map((file) => Image.network(file.url)).toList();

    final icon = alertIcons[alert.category.name] ?? Icons.warning_rounded;
    final date = DateFormat('dd/MM/yyyy').format(alert.dtHr);
    final time = DateFormat('HH:mm').format(alert.dtHr);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 18, left: 22, right: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                spacing: 18,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withAlpha(15),
                      child: Icon(icon, color: AppColors.textPrimary, size: 18),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert.category.name,
                        style: AppTextStyles.titleMedium,
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
                style: AppTextStyles.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        media.isNotEmpty
            ? CarouselSlider(
                options:
                    CarouselOptions(height: 200.0, enableInfiniteScroll: false),
                items: media.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 204, 203, 203)),
                        child: i,
                      );
                    },
                  );
                }).toList(),
              )
            : Placeholder(
                fallbackHeight: 0,
                fallbackWidth: 0,
              ),
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          height: 300,
          width: 300,
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
                      BitmapDescriptor.hueViolet),
                  position: LatLng(alert.local.latitude, alert.local.longitude))
            },
            onMapCreated: (GoogleMapController control) {
              controller.complete(control);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'Relatado por Asa',
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
