import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/di/di_container.dart';

abstract class BaseVm extends ChangeNotifier {
  // Expose DI container to view model
  final di = DiContainer();

  /// Is loading
  final isLoading = ValueNotifier(false);

  /// Show loading
  void postLoading(bool loading) {
    isLoading.value = loading;
  }
}
