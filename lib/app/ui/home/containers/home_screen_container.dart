import 'package:eiviznho/app/config/dependencies.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/home/interfaces/home_screen_interface.dart';
import 'package:eiviznho/app/utils/get_current_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:june/june.dart';
import 'package:latlong2/latlong.dart';

class AlertsHomeState extends JuneState {
  List<Alert> alerts = [];
  bool isLoading = false;
}

class HomeScreenContainer extends StatefulWidget {
  const HomeScreenContainer({super.key});

  @override
  State<HomeScreenContainer> createState() => _HomeScreenContainerState();
}

class _HomeScreenContainerState extends State<HomeScreenContainer> {
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _alertRepository = injector.get<AlertRepository>();
    _fetchAlerts();
    _getUserLocation();
  }

  Future<void> _fetchAlerts() async {
    AlertsHomeState alertsState = June.getState(() => AlertsHomeState());
    try {
      alertsState
        ..isLoading = true
        ..setState();

      final result = await _alertRepository.getAllAlerts();

      alertsState
        ..alerts = result
        ..setState();
    } catch (e) {
      alertsState
        ..alerts = []
        ..setState();
    } finally {
      alertsState
        ..isLoading = false
        ..setState();
    }
  }

  Future<void> _getUserLocation() async {
    try {
      final position = await getCurrentPosition();
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      print("Erro ao obter localização: $e");
    }
  }

  late AlertRepository _alertRepository;

  List<Marker> _buildMarkers() {
    AlertsHomeState alertsState = June.getState(() => AlertsHomeState());

    return alertsState.alerts
        .map((alert) => Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(alert.local.latitude, alert.local.longitude),
              child: Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40.0,
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenInterface(
        currentPosition: currentPosition, markers: _buildMarkers());
  }
}
