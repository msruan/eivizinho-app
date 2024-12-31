import 'package:eiviznho/app/styles/text.styles.dart';
import 'package:eiviznho/app/ui/pages/AlertList/alert_list_injection.dart';
import 'package:eiviznho/app/ui/pages/AlertList/alert_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  setupAlertListInject();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meili",
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
      home: const AlertListPage(),
    );
  }
}
