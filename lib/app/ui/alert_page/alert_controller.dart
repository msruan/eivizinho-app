import 'dart:async';

import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/alert_page/alert_interface.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AlertPageController extends StatefulWidget {
  final Alert alert;

  const AlertPageController({
    super.key,
    required this.alert,
  });

  @override
  State<AlertPageController> createState() => _AlertPageControllerState();
}

class _AlertPageControllerState extends State<AlertPageController> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return AlertPageInterface(
      alert: widget.alert,
      controller: _controller,
    );
  }
}
