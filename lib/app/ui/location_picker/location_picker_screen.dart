import 'package:eiviznho/app/ui/shared/button_widget.dart';
import 'package:eiviznho/app/ui/shared/loading_widget.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng _selectedLocation = LatLng(0.0, 0.0);
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setDefaultLocation();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _setDefaultLocation();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _setDefaultLocation();
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    _updateLocation(LatLng(position.latitude, position.longitude));
  }

  void _setDefaultLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    _updateLocation(LatLng(position.latitude, position.longitude));
  }

  void _updateLocation(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _isLoading = false;
    });
  }

  void _confirmLocation() {
    Navigator.pop(context, _selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selecione a localização")),
      body: _isLoading
          ? LoadingWidget()
          : SafeArea(
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _selectedLocation,
                      zoom: 15,
                    ),
                    onMapCreated: (controller) {},
                    onCameraMove: (position) {
                      _updateLocation(position.target);
                    },
                  ),
                  Center(
                    child:
                        Icon(Icons.location_pin, size: 50, color: Colors.red),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    right: 20,
                    child: Button(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPress: _confirmLocation,
                      title: "Confirmar localização",
                      isLoading: _isLoading,
                      backgroundColor: AppColors.green,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
