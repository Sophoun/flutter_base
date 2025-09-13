import 'package:example/service/mock_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/flutter_base.dart';

class HomeVm extends ChangeNotifier {
  late final mockService = inject<MockService>();

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

  Future<void> loadingForever() async {
    postLoading(true);
  }

  /// increment counter
  void incrementCounter() {
    counter.value++;
    EventBus.fire(1, data: "Hi in");
  }

  /// decrement counter
  void decrementCounter() {
    if (counter.value > 0) {
      counter.value--;
    }
    EventBus.fire(2, data: "Hi de");
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
