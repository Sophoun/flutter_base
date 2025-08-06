import 'package:flutter/widgets.dart';

abstract class BaseVm extends ChangeNotifier {
  /// Is loading
  final isLoading = ValueNotifier(false);

  /// Show loading
  void postLoading(bool loading) {
    isLoading.value = loading;
  }
}
