import 'dart:async';

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
                      backgroundColor: AppColors.backgroundPrimary,
                      elevation: 4,
                      child: const Icon(
                        color: AppColors.textPrimary,
                        Icons.my_location,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 16,
                  right: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (suggestions.isNotEmpty)
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 200,
                          ),
                          child: Container(
                            color: Colors.white,
                            child: ListView.builder(
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
                            ),
                          ),
                        ),
                      TextField(
                        controller: textController,
                        onChanged: getSuggestions,
                        focusNode: focusNode,
                        decoration: InputDecoration(
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
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
