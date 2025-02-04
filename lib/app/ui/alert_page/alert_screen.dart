import 'package:eiviznho/app/domain/entities/alert_entity.dart';
import 'package:eiviznho/app/ui/alert_page/alert_controller.dart';
import 'package:eiviznho/app/ui/shared/app_bar.dart';
import 'package:flutter/material.dart';

class AlertPageScreen extends StatelessWidget {
  final Alert alert;
  const AlertPageScreen({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(title: "Alerta"),
      body: SafeArea(
        child: AlertPageController(
          alert: alert,
        ),
      ),
    );
  }
}
