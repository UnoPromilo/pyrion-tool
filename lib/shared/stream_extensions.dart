import 'package:grpc/grpc.dart';

import 'result.dart';

extension StreamExtensions<T> on Stream<T> {
  Future<Result<T, TryFirstResult>> get tryFirst => _tryFirst();

  Future<Result<T, TryFirstResult>> _tryFirst() async {
    try {
      return await this
          .map<Result<T, TryFirstResult>>(Success.new)
          .firstWhere(
            (_) => true,
            orElse: () => const Failure(TryFirstResult.noElement),
          );
    } on GrpcError {
      return const Failure(TryFirstResult.grpcException);
    }
  }
}

enum TryFirstResult { noElement, grpcException }
