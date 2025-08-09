sealed class Result<T> {
  const Result();

  factory Result.success(T value) => Success(value);

  factory Result.error(Exception error) => Error(e: error);
}

final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

final class Error<T> extends Result<T> {
  final Exception e;

  Error({required this.e});
}
