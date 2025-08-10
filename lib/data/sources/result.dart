sealed class Result<T> {
  const Result();

  factory Result.success(T value) => Success._(value);

  factory Result.error(Object e) => Error._(e is Exception ? e : Exception(e.toString()));
}
/// A successful [Result] with a returned [value].
final class Success<T> extends Result<T> {
  const Success._(this.value);

  /// The returned value of this result.
  final T value;

  @override
  String toString() => 'Result<$T>.success($value)';
}

/// An error [Result] with a resulting [error].
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// The resulting error of this result.
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}