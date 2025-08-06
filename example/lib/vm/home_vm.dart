import 'package:flutter/widgets.dart';
import 'package:flutter_base/flutter_base.dart';

class HomeVm extends BaseVm {
  /// Counter variable
  final counter = ValueNotifier(10);

  /// Try show loading
  Future<void> tryShowLoading() async {
    postLoading(true);
    await Future.delayed(Duration(milliseconds: 500));
    postLoading(false);
  }

  /// increment counter
  void incrementCounter() {
    counter.value++;
  }

  /// decrement counter
  void decrementCounter() {
    if (counter.value > 0) {
      counter.value--;
    }
  }
}
