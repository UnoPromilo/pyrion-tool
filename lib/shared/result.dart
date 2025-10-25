import 'dart:async';

import 'package:flutter/foundation.dart';

/// Either a [Success] or an [Failure] result.
sealed class Result<TData, TError> {}

/// A successful result with data.
@immutable
final class Success<TData, TError> implements Result<TData, TError> {
  const Success(this.data);

  final TData data;

  @override
  String toString() => 'Success(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Success && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

/// An unsuccessful result with an error.
@immutable
final class Failure<TData, TError> implements Result<TData, TError> {
  const Failure(this.error);

  final TError error;

  @override
  String toString() => 'Error(error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Failure && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

extension ResultExtensions<TData, TError> on Result<TData, TError> {
  Result<TDataOut, TError> mapSuccess<TDataOut>(
    TDataOut Function(TData data) mapping,
  ) {
    return switch (this) {
      Success(:final data) => Success(mapping(data)),
      Failure(:final error) => Failure(error),
    };
  }

  Result<TData, TErrorOut> mapError<TErrorOut>(
    TErrorOut Function(TError error) mapping,
  ) {
    return switch (this) {
      Success(:final data) => Success(data),
      Failure(:final error) => Failure(mapping(error)),
    };
  }

  Future<Result<TDataOut, TError>> mapSuccessAsync<TDataOut>(
    Future<TDataOut> Function(TData data) mapping,
  ) async {
    return switch (this) {
      Success(:final data) => Success(await mapping(data)),
      Failure(:final error) => Failure(error),
    };
  }

  Future<Result<TData, TErrorOut>> mapErrorAsync<TErrorOut>(
    Future<TErrorOut> Function(TError error) mapping,
  ) async {
    return switch (this) {
      Success(:final data) => Success(data),
      Failure(:final error) => Failure(await mapping(error)),
    };
  }

  FutureOr<Result<TData, TError>> thenDo(
    FutureOr<Result<TData, TError>> Function() callback,
  ) async {
    return switch (this) {
      Success() => callback(),
      Failure() => this,
    };
  }
}

extension FutureResultExtensions<TSuccess, TError>
    on Future<Result<TSuccess, TError>> {
  Future<Result<TSuccess, TError>> thenDo(
    Future<Result<TSuccess, TError>> Function() callback,
  ) async {
    final result = await this;
    return await result.thenDo(callback);
  }
}
