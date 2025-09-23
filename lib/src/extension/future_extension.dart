extension FutureExtension<T> on Future<T> {
  /// Executes the future and handles its result with callbacks.
  ///
  /// This extension provides a convenient way to handle the different states
  /// of a `Future` (start, success, error, and end) using callbacks.
  ///
  /// - [onStart]: Called before the future is awaited.
  /// - [onSuccess]: Called when the future completes successfully with data.
  /// - [onError]: Called when the future completes with an error.
  /// - [onEnd]: Called after the future completes, regardless of success or error.
  Future<void> execute({
    required void Function(T data) onSuccess,
    required void Function(Exception e) onError,
    void Function()? onStart,
    void Function()? onEnd,
  }) async {
    onStart?.call();
    try {
      final result = await this;
      onSuccess(result);
    } catch (e) {
      onError(e as Exception);
    } finally {
      onEnd?.call();
    }
  }
}
