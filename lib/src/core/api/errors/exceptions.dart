import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  factory ServerException.fromDioException(DioException dioException) {
    return ServerException(
      message: dioException.response?.data['message'] ?? 'Unknown error',
      statusCode: dioException.response?.statusCode.toString() ?? '500',
    );
  }

  final String message;
  final String statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message, this.statusCode = 500});

  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}

class TimeoutException implements Exception {
  final String message;
  final String? statusCode;

  TimeoutException({required this.message, this.statusCode});
}

class BadRequestException implements Exception {
  final String message;
  final String? statusCode;

  BadRequestException({required this.message, this.statusCode});
}

class UnauthorizedException implements Exception {
  final String message;
  final String? statusCode;

  UnauthorizedException({required this.message, this.statusCode});
}

class ForbiddenException implements Exception {
  final String message;
  final String? statusCode;

  ForbiddenException({required this.message, this.statusCode});
}

class NotFoundException implements Exception {
  final String message;
  final String? statusCode;

  NotFoundException({required this.message, this.statusCode});
}