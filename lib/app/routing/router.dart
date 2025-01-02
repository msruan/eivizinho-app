import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/alert_list/alert_list_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: Routes.home, routes: [
  GoRoute(path: Routes.home, builder: (context, state) => AlertListPage())
]);
