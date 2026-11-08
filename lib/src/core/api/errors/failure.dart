import 'package:equatable/equatable.dart';
import 'package:base_flutter/src/core/api/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final String statusCode;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
    : this(message: exception.message, statusCode: exception.statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, required super.statusCode});
}