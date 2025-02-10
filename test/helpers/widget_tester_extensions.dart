import 'package:eiviznho/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpRealApp() async {
    await pumpWidget(const App());
    await pumpAndSettle();
  }
}
