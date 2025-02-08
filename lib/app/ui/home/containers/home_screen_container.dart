import 'dart:async';
import 'dart:convert';

import 'package:eiviznho/app/config/dependencies.dart';
import 'package:eiviznho/app/config/env.dart';
import 'package:eiviznho/app/data/repositories/alert/alert_repository.dart';
import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/alert_list/components/alert_details.dart';
import 'package:eiviznho/app/ui/home/interfaces/home_screen_interface.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../utils/get_current_position.dart';

class HomeScreenContainer extends StatefulWidget {
  const HomeScreenContainer({super.key});

  @override
  State<HomeScreenContainer> createState() => HomeScreenContainerState();
}

class HomeScreenContainerState extends State<HomeScreenContainer> {
  final String apiKey = Enviroment.googleApiKey() ?? "undefined";

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Position? _currentPosition;
  Set<Marker> _markers = {};

  late AlertRepository _alertRepository;

  List<Map<String, dynamic>> _suggestions = [];
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final Map<String, double> categoryColors = {
    'assalto': BitmapDescriptor.hueRed,
    'incêndio': BitmapDescriptor.hueOrange,
    'acidente': BitmapDescriptor.hueYellow,
    'furto': BitmapDescriptor.hueBlue,
  };

  @override
  void initState() {
    super.initState();
    _alertRepository = injector.get<AlertRepository>();
    _fetchAlerts();
    _getUserLocation();

    _textController.addListener(() {
      if (_textController.text.isEmpty) {
        setState(() {
          _suggestions = [];
        });
      }
    });

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _suggestions = [];
        });
      }
    });
  }

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
              icon: BitmapDescriptor.defaultMarkerWithHue(hue),
              onTap: () => _showAlertDetailsDialog(context, alert));
        }).toSet();
      });
    } catch (e) {
      print("Erro ao buscar alertas para o mapa: $e");
    }
  }

  void _showAlertDetailsDialog(BuildContext context, Alert alert) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDetails(alert: alert);
      },
    );
  }

  Future<void> _getUserLocation() async {
    try {
      final position = await getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
      _moveCameraToPosition(position);
    } catch (e) {
      print("Erro ao obter localização do usuário: $e");
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

  Future<void> _getSuggestions(String input) async {
    if (input.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    const double latitudeTeresina = -5.0919;
    const double longitudeTeresina = -42.8034;
    const int searchRadius = 20000;

    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input'
        '&key=$apiKey'
        '&location=$latitudeTeresina,$longitudeTeresina'
        '&radius=$searchRadius'
        '&language=pt';
    '&types=address';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final predictions = json.decode(response.body)['predictions'] as List;

        setState(() {
          _suggestions = predictions
              .map((item) => {
                    'description': item['description'],
                    'place_id': item['place_id'],
                  })
              .toList();
        });
      } else {
        print('Erro na API do Google Places: ${response.body}');
      }
    } catch (e) {
      print('Erro ao buscar sugestões: $e');
    }
  }

  Future<Position?> _getPlaceDetails(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final result = json.decode(response.body)['result'];
        final location = result['geometry']['location'];

        return Position(
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0,
          latitude: location['lat'],
          longitude: location['lng'],
          timestamp: DateTime.now(),
        );
      }
    } catch (e) {
      print('Erro ao buscar detalhes do lugar: $e');
    }
    return null;
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Descartando o FocusNode corretamente
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenInterface(
      currentPosition: _currentPosition,
      markers: _markers,
      controller: _controller,
      textController: _textController,
      getSuggestions: _getSuggestions,
      moveCameraToPosition: _moveCameraToPosition,
      suggestions: _suggestions,
      onSuggestionTap: (placeId) async {
        setState(() {
          _suggestions = [];
        });
        final position = await _getPlaceDetails(placeId);
        if (position != null) {
          _moveCameraToPosition(position);
        }
      },
      focusNode: _focusNode,
    );
  }
}
