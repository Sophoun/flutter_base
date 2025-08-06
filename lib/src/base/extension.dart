import 'package:flutter/widgets.dart';

extension ValueNotifierAsWidgetBuilder<T> on ValueNotifier<T?> {
  /// Converts the ValueNotifier to a Widget that rebuilds when the value changes.
  Widget builder({required Widget Function(T? value) build, Key? key}) {
    return ValueListenableBuilder<T?>(
      valueListenable: this,
      builder: (context, value, child) {
        return build(value);
      },
      key: key,
    );
  }
}
