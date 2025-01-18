import 'dart:async';

import 'package:eiviznho/app/config/dependencies.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/ui/home/interfaces/home_screen_interface.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/get_current_position.dart';

class HomeScreenContainer extends StatefulWidget {
  const HomeScreenContainer({super.key});

  @override
  State<HomeScreenContainer> createState() => HomeScreenContainerState();
}

class HomeScreenContainerState extends State<HomeScreenContainer> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late AlertRepository _alertRepository;
  Position? _currentPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _alertRepository = injector.get<AlertRepository>();
    _fetchAlerts();
    _getUserLocation();
  }

  final Map<String, double> categoryColors = {
    'assalto': BitmapDescriptor.hueRed,
    'incêndio': BitmapDescriptor.hueOrange,
    'acidente': BitmapDescriptor.hueYellow,
    'furto': BitmapDescriptor.hueBlue,
  };

  Future<void> _fetchAlerts() async {
    try {
      final alerts = await _alertRepository.getAllAlerts();
      setState(() {
        _markers = alerts.map((alert) {
          final hue =
              categoryColors[alert.category.name] ?? BitmapDescriptor.hueViolet;
          return Marker(
            markerId: MarkerId(alert.id.toString()),
            position: LatLng(alert.local.latitude, alert.local.longitude),
            infoWindow: InfoWindow(
                title: alert.category.name, snippet: alert.description),
            icon: BitmapDescriptor.defaultMarkerWithHue(hue),
          );
        }).toSet();
      });
    } catch (e) {
      print("Erro ao buscar alertas: $e");
    }
  }

  Future<void> _getUserLocation() async {
    try {
      final position = await getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
      _moveCameraToPosition(position);
    } catch (e) {
      print("Erro ao obter localização: $e");
    }
  }

  Future<void> _moveCameraToPosition(Position position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenInterface(
        currentPosition: _currentPosition,
        markers: _markers,
        controller: _controller,
        moveCameraToPosition: _moveCameraToPosition);
  }
}
