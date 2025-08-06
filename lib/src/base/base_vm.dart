import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/di/di_container.dart';

abstract class BaseVm extends ChangeNotifier {
  /// Get the di object of type [T]
  T getDi<T>() => DiContainer.get<T>();

  /// Is loading
  final isLoading = ValueNotifier(false);

  /// Show loading
  void postLoading(bool loading) {
    isLoading.value = loading;
  }
}
