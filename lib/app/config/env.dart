import 'package:eiviznho/app/config/exceptions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class Enviroment {
  static baseUrl() => dotenv.env['BASE_URL'];
  static String? googleApiKey() => dotenv.env['GOOGLE_API_KEY'];

  static void validate() {
    final List<String?> envs = [baseUrl(), googleApiKey()];
    for (String? env in envs) {
      if (env == null) {
        throw InternalSystemException(
            "Please set all enviroments on .env.example!");
      }
    }
  }
}
