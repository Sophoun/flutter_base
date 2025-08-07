import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/di/di_container.dart';

/// Is loading
final isAppLoading = ValueNotifier(false);

abstract class BaseVm extends ChangeNotifier {
  // Expose DI container to view model
  final di = DiContainer();

  bool isLoading() => isAppLoading.value;

  /// Show loading
  void postLoading(bool loading) {
    isAppLoading.value = loading;
  }
}
