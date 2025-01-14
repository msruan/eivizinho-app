import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class HomeScreenInterface extends StatelessWidget {
  final Position? currentPosition;
  final List<Marker> markers;

  const HomeScreenInterface({
    super.key,
    required this.currentPosition,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          if (currentPosition != null)
            FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                    currentPosition!.latitude, currentPosition!.longitude),
                initialZoom: 18.0,
                maxZoom: 20.0,
                minZoom: 8.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(markers: markers),
              ],
            )
          else
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
