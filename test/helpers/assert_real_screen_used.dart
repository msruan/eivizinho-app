import 'package:eiviznho/app/routing/router.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_tester_extensions.dart';

Future<void> assertScreenUsed(
    WidgetTester tester, String route, Type screen) async {
  await tester.pumpRealApp();

  router.go(route);

  await tester.pumpAndSettle();

  expect(find.byType(screen), findsOneWidget);
}
