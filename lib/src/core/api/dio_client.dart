import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:base_flutter/src/core/local_storage/local_storage_key.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 120),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Auth Interceptor: Tự động gắn Bearer Token nếu có trong Hive
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          try {
            if (Hive.isBoxOpen(LocalStorageKey.token)) {
              final box = Hive.box(LocalStorageKey.token);
              final token = box.get('accessToken') as String?;
              if (token != null && token.isNotEmpty) {
                options.headers['Authorization'] = 'Bearer $token';
              }
            }
          } catch (_) {}
          return handler.next(options);
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.patch<T>(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
