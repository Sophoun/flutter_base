import 'package:flutter/foundation.dart';

/// ValueNotifier with added listener by default
class ValueNotifierWithListener<T> extends ValueNotifier<T> {
  ValueNotifierWithListener(super.value, this.onValueChanges) {
    /// Early register listener
    addListener(_listener);
  }

  /// Callback with value
  void Function(T value) onValueChanges;

  /// Current value listener
  void _listener() {
    onValueChanges.call(value);
  }

  @override
  void dispose() {
    removeListener(_listener);
    super.dispose();
  }
}
