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

/// Either operation
sealed class Either<R, L> {}

/// Success result Right
class Right<R, L> extends Either<R, L> {
  final R value;
  Right(this.value);
}

/// Failed result Left
class Left<R, L> extends Either<R, L> {
  final L value;
  Left(this.value);
}

/// Either exception
class EitherException implements Exception {
  final String code;
  final String message;

  EitherException({this.code = "", required this.message});

  @override
  String toString() {
    return "${code.isEmpty ? '' : '$code - '}$message";
  }
}

// L is constrained to be an Exception, as you intended to catch errors.
extension EitherExtension<R, L extends EitherException> on Future<R> {
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

      try {
        /// Try cast to L
        if (e is EitherException) {
          return Left(e as L);
        }

        /// Rewrite exception message
        if (e is Exception) {
          return Left(
            EitherException(
                  message: e
                      .toString()
                      .replaceFirst("Exception: ", "")
                      .replaceFirst("Exception", ""),
                )
                as L,
          );
        }
      } catch (_) {
        // If the caught object is not of type L,
        // we must re-throw it or handle it as a different error type.
        // Re-throwing is safer than an incorrect cast.
        rethrow;
      }
    } finally {
      onEnd?.call();
    }
  }
}

extension FutureEitherBindExtension<R, L> on Future<Either<R, L>> {
  /// Sequentially executes the next asynchronous function (binder)
  /// ONLY if the current Future resolves to a Right (Success).
  ///
  /// R2 is the Success type of the NEXT operation.
  Future<Either<R2, L>> bind<R2>(
    Future<Either<R2, L>> Function(R value) binder,
  ) async {
    // 1. Await the result of the first future (Future<Either<R, L>>).
    final result = await this;

    // 2. Switch on the result type.
    return switch (result) {
      // 3. If it's a Right (Success), call the next async function (`binder`)
      //    with the successful value (R) and await its result (Future<Either<R2, L>>).
      Right(value: final value) => await binder(value),

      // 4. If it's a Left (Failure), short-circuit the entire process
      //    by immediately returning the existing Left result.
      Left(value: final error) => Left(error),
    };
  }
}
