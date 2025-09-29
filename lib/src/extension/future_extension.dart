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

// L is constrained to be an Exception, as you intended to catch errors.
extension EitherExtension<R, L extends Exception> on Future<R> {
  // The method now returns Future<Either<R, L>>
  Future<Either<R, L>> toEither({
    void Function()? onStart,
    void Function()? onEnd,
  }) async {
    onStart?.call();
    try {
      final result = await this;
      // Success: Return a Right<R, L>
      return Right(result);
    } catch (e) {
      // Failure: Check if the error is the expected type L
      if (e is L) {
        // Safe cast if the type check passes
        return Left(e);
      }

      // If the caught object is not of type L,
      // we must re-throw it or handle it as a different error type.
      // Re-throwing is safer than an incorrect cast.
      rethrow;
    } finally {
      onEnd?.call();
    }
  }
}

sealed class Either<R, L> {}

class Right<R, L> extends Either<R, L> {
  final R value;
  Right(this.value);
}

class Left<R, L> extends Either<R, L> {
  final L value;
  Left(this.value);
}
