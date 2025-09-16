import 'package:flutter/foundation.dart';

/// Log utility, help you keep it out from import `developer`
void log(String? message) {
  if (kDebugMode) {
    // ignore: avoid_print
    print(message);
  }
}
