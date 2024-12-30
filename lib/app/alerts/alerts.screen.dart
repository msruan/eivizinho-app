import 'package:eiviznho/app/alerts/alerts_list.widget.dart';
import 'package:eiviznho/app/shared/base_screen.widget.dart';
import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Alertas',
      content: Center(child: AlertsListWidget()),
    );
  }
}
