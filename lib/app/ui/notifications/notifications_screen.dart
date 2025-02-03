import 'package:eiviznho/app/ui/shared/drawer.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: baseAppBar(title: 'Notificações'),
      body: SafeArea(
          child: const Placeholder(
        fallbackHeight: 120,
        fallbackWidth: 120,
      )),
      drawer: MainDrawer()
    );
  }
}
