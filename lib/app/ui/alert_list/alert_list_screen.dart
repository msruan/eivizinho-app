import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/alert_list/containers/alert_list_container.dart';
import 'package:eiviznho/app/ui/themes/screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertListScreen extends StatelessWidget {
  const AlertListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBaseScreen.appBar(title: "Alertas"),
      body: SafeArea(
        child: AlertListContainer(),
      ),
      bottomNavigationBar: AppBaseScreen.bottomNavigationBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(Routes.createAlert),
        child: const Icon(Icons.add),
      ),
    );
  }
}
