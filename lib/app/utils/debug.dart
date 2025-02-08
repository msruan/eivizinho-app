import 'package:flutter/foundation.dart';

String? debug(Object object) {
  if (kDebugMode) {
    print('Debug: ${object.toString()}');
    return object.toString();
  }
  return null;
}
