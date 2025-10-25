import 'package:grpc/grpc.dart';

sealed class RemoteResult<T> {
  const RemoteResult();

  factory RemoteResult.success(T data) => RemoteSuccess(data);

  factory RemoteResult.fromGrpcError(GrpcError error) {
    switch (error.code) {
      case StatusCode.aborted:
        return const RemoteError._(RemoteErrorType.aborted);
      case StatusCode.unavailable:
        return const RemoteError._(RemoteErrorType.unavailable);
      case StatusCode.dataLoss:
        return const RemoteError._(RemoteErrorType.dataLoss);
      case StatusCode.unauthenticated:
        return const RemoteError._(RemoteErrorType.unauthenticated);

      default:
        return const RemoteError._(RemoteErrorType.unknown);
    }
  }

  factory RemoteResult.cantMap() {
    return const RemoteError._(RemoteErrorType.cantMap);
  }
}

final class RemoteSuccess<T> extends RemoteResult<T> {
  const RemoteSuccess(this.data);

  final T data;

  @override
  String toString() => 'RemoteSuccess: ${data.runtimeType}';
}

final class RemoteError<T> extends RemoteResult<T> {
  const RemoteError._(this.error);

  final RemoteErrorType error;

  @override
  String toString() => 'RemoteError: $error';
}

enum RemoteErrorType {
  aborted,
  unavailable,
  dataLoss,
  unauthenticated,
  cantMap,
  unknown,
}
