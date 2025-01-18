import 'dart:async';

import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreenInterface extends StatelessWidget {
  final Position? currentPosition;
  final Set<Marker> markers;
  final Completer<GoogleMapController> controller;
  final void Function(Position position) moveCameraToPosition;

  const HomeScreenInterface({
    super.key,
    required this.currentPosition,
    required this.markers,
    required this.controller,
    required this.moveCameraToPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.textPrimary,
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentPosition!.latitude,
                      currentPosition!.longitude,
                    ),
                    zoom: 14.0,
                  ),
                  markers: markers,
                  onMapCreated: (GoogleMapController control) {
                    controller.complete(control);
                  },
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: SizedBox(
                    height: 40, 
                    width: 40, 
                    child: FloatingActionButton(
                      onPressed: () {
                        if (currentPosition != null) {
                          moveCameraToPosition(currentPosition!);
                        }
                      },
                      backgroundColor:
                          AppColors.backgroundPrimary, 
                      elevation: 4,
                      child: const Icon(
                        color: AppColors.textPrimary,
                        Icons.my_location,
                        size: 20, 
                      ), 
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
