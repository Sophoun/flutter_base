import 'package:example/service/mock_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/flutter_base.dart';

class HomeVm extends ChangeNotifier {
  late final mockService = di.get<MockService>();

  /// Counter variable
  final counter = ValueNotifier(10);

  /// Mock value
  final mockValue = ValueNotifier("unknow");

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

  /// get mock data
  void getMockData() {
    postLoading(true);
    mockService
        .getHelloWorld()
        .then((v) => mockValue.value = v)
        .whenComplete(() => postLoading(false));
  }
}
