import 'package:eiviznho/app/app.dart';
import 'package:eiviznho/app/config/dependencies.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  setupGetItInject();
  runApp(const App());
}
