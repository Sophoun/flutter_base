import 'package:flutter/widgets.dart';

extension SafePopExtension on BuildContext? {
  /// Handle safe pop for screen
  void safePop() {
    if (this == null) return;
    if (Navigator.of(this!).canPop()) {
      Navigator.of(this!).pop();
    }
  }
}
