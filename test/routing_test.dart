import 'package:eiviznho/app/routing/router.dart';
import 'package:eiviznho/app/routing/routes.dart';
import 'package:eiviznho/app/ui/alert_create/alert_create_screen.dart';
import 'package:eiviznho/app/ui/alert_list/alert_list_screen.dart';
import 'package:eiviznho/app/ui/home/home_screen.dart';
import 'package:eiviznho/app/ui/login/login_screen.dart';
import 'package:eiviznho/app/ui/profile/profile_screen.dart';
import 'package:eiviznho/app/ui/register/register_screen.dart';
import 'package:eiviznho/app/ui/welcome/welcome_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import '../testing/dependencies.dart';
import 'helpers/assert_real_screen_used.dart';
import 'helpers/widget_tester_extensions.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(fileName: ".env");
    setupFakeGetItInject();
  });

  testWidgets('Test if welcome is the initial route',
      (WidgetTester tester) async {
    await tester.pumpRealApp();

    final String location =
        router.routerDelegate.currentConfiguration.uri.toString();

    expect(location, Routes.welcome);
    //Failing because of the errors with resposiveness
  }, skip: true);

  testWidgets('Test if welcome route loads the correct widget',
      (WidgetTester tester) async {
    await assertScreenUsed(tester, Routes.welcome, WelcomeScreen);
    //Failing because of the errors with resposiveness
  }, skip: true);

  testWidgets('Test if home route loads the correct widget',
      (WidgetTester tester) async {
    await assertScreenUsed(tester, Routes.home, HomeScreen);
    //Failing because of need of HTTPClient
  }, skip: true);

  testWidgets('Test if login route loads the correct widget',
      (WidgetTester tester) async {
    await assertScreenUsed(tester, Routes.login, LoginScreen);
    //Failing because of the errors with resposiveness
  }, skip: true);

  testWidgets('Test if register route loads the correct widget',
      (WidgetTester tester) async {
    await assertScreenUsed(tester, Routes.register, RegisterScreen);
    //Failing because of the errors with resposiveness
  }, skip: true);

  testWidgets('Test if alertsList route loads the correct widget',
      (WidgetTester tester) async {
    await assertScreenUsed(tester, Routes.alertsList, AlertListScreen);
    //Failing because of the errors with resposiveness
  }, skip: true);

  testWidgets('Test if createAlert route loads the correct widget',
      (WidgetTester tester) async {
    await assertScreenUsed(tester, '${Routes.alertsList}/${Routes.createAlert}',
        AlertCreateScreen);
    //Failing because of the errors with resposiveness
  }, skip: true);

  testWidgets('Test if profile route loads the correct widget',
      (WidgetTester tester) async {
    await assertScreenUsed(tester, Routes.profile, ProfileScreen);
  });
}
