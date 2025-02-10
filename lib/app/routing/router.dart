import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/alert_create/alert_create_screen.dart';
import 'package:eiviznho/app/ui/alert_list/alert_list_screen.dart';
import 'package:eiviznho/app/ui/home/home_screen.dart';
import 'package:eiviznho/app/ui/layouts/main_layout.dart';
import 'package:eiviznho/app/ui/login/login_screen.dart';
import 'package:eiviznho/app/ui/notifications/notifications_screen.dart';
import 'package:eiviznho/app/ui/profile/profile_screen.dart';
import 'package:eiviznho/app/ui/register/register_screen.dart';
import 'package:eiviznho/app/ui/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final Map<String, String> routeTitles = {
  Routes.home: '',
  Routes.notifications: 'Notificações',
  Routes.alertsList: 'Alertas'
};

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: Routes.welcome,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: Routes.welcome, builder: (context, state) => WelcomeScreen()),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        final String location = state.uri.toString();
        final String title = routeTitles[location] ?? '';
        return MainLayout(content: child, title: title);
      },
      routes: [
        GoRoute(
          path: Routes.home,
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: Routes.notifications,
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: Routes.alertsList,
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const AlertListScreen(),
          routes: [
            GoRoute(
              path: Routes.createAlert,
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const AlertCreateScreen(),
            ),
          ],
        ),
      ],
    )
  ],
);
