import 'package:eiviznho/app/config/env.dart';
import 'package:eiviznho/app/routing/router.dart';

import 'package:eiviznho/app/ui/themes/text_styles.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  static ThemeData theme = ThemeData(
    primaryColor: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Enviroment.validate();

    return MaterialApp.router(
        title: "Ei Vizinho!", routerConfig: router, theme: theme);
  }
}
