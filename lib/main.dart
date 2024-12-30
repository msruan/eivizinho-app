import 'package:flutter/material.dart';
import 'package:eiviznho/app/alerts/alerts_list.widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            height: 500,
            width: 1000,
            child: AlertsListContainer(),
          ),
        ),
      ),
    );
  }
}
