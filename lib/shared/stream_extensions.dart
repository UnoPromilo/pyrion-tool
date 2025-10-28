import 'result.dart';

extension StreamExtensions<T> on Stream<T> {
  Future<Result<T, NoElement>> get tryFirst => _tryFirst();

  Future<Result<T, NoElement>> _tryFirst() async {
    return this
        .map<Result<T, NoElement>>(Success.new)
        .firstWhere((_) => true, orElse: () => const Failure(NoElement()));
  }
}

class NoElement {
  const NoElement();
}
