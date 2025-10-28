import 'result.dart';

extension FutureExtensions<T> on Future<T> {
  Future<Result<T, Timeout>> failingTimeout(Duration duration) {
    return this
        .then<Result<T, Timeout>>(Success.new)
        .timeout(duration, onTimeout: () => const Failure(Timeout()));
  }
}

class Timeout {
  const Timeout();
}
