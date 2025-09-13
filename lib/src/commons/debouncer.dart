import 'dart:async';

class Debouncer {
  final Duration delay;
  Timer? _timer;

  /// Create a debounce with duration delay of 2 seconds
  Debouncer({this.delay = const Duration(seconds: 2)});

  /// Run the specific task after reach that delay time
  void run(Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancel the task
  void dispose() {
    _timer?.cancel();
  }
}
