import 'package:eiviznho/app/ui/notifications/containers/notifications_container.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: baseAppBar(title: 'Notificações'),
      body: SafeArea(child: NotificationsContent()),
    );
  }
}
