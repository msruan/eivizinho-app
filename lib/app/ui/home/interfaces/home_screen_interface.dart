import 'dart:async';

import 'package:eiviznho/app/ui/shared/drawer.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreenInterface extends StatelessWidget {
  final Position? currentPosition;
  final Set<Marker> markers;
  final Completer<GoogleMapController> controller;
  final void Function(Position position) moveCameraToPosition;
  final TextEditingController textController;
  final void Function(String input) getSuggestions;
  final List<Map<String, dynamic>> suggestions;
  final void Function(String placeId) onSuggestionTap;
  final FocusNode focusNode;

  const HomeScreenInterface({
    super.key,
    required this.currentPosition,
    required this.markers,
    required this.controller,
    required this.moveCameraToPosition,
    required this.textController,
    required this.getSuggestions,
    required this.suggestions,
    required this.onSuggestionTap,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: MainDrawer(),
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
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  onMapCreated: (GoogleMapController control) {
                    controller.complete(control);
                  },
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: textController,
                        onChanged: getSuggestions,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          hintText: 'Buscar localização...',
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                      SizedBox(height: 6),
                      if (suggestions.isNotEmpty)
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 250,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: suggestions.length,
                              itemBuilder: (context, index) {
                                final suggestion = suggestions[index];
                                return ListTile(
                                  title: Text(suggestion['description']!,
                                      style: AppTextStyles.bodyMedium),
                                  onTap: () =>
                                      onSuggestionTap(suggestion['place_id']!),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
