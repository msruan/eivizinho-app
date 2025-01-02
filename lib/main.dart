import 'package:eiviznho/app/routing/router.dart';
import 'package:eiviznho/app/ui/alert_create/alert_create_injection.dart';
import 'package:eiviznho/app/ui/alert_list/alert_list_injection.dart';
import 'package:eiviznho/app/ui/styles/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupAlertListInject();
  setupAlertTypeInject();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Ei Vizinho!",
      routerConfig: router,
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          titleLarge: AppTextStyles.titleLarge,
          titleMedium: AppTextStyles.titleMedium,
        ),
      ),
    );
  }
}
