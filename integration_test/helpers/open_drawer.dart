import 'package:flutter_test/flutter_test.dart';

Future<void> openDrawer(WidgetTester tester) async {
  await tester.dragFrom(const Offset(0, 300), const Offset(300, 300));
  await tester.pumpAndSettle();
}
