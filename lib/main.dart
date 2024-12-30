import 'package:eiviznho/app/alerts/alerts.screen.dart';
import 'package:eiviznho/app/shared/base_screen.widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(title: 'Alertas', content: AlertsScreen());
  }
}
