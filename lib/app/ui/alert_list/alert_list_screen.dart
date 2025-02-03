import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/alert_list/containers/alert_list_container.dart';
import 'package:eiviznho/app/ui/shared/drawer.dart';
import 'package:eiviznho/app/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertListScreen extends StatelessWidget {
  const AlertListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AlertListContainer(),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundPrimary,
        onPressed: () =>
            context.go('${Routes.alertsList}/${Routes.createAlert}'),
        child: const Icon(
          Icons.add,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
