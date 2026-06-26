import 'package:dio/dio.dart';

import '../storage/secure_storage_service.dart';
import 'auth_interceptor.dart';

class ApiClient {
  ApiClient(SecureStorageService storage)
    : dio = Dio(
        BaseOptions(
          baseUrl: const String.fromEnvironment(
            'API_BASE_URL',
            defaultValue: 'https://ai-business-suite.onrender.com',
          ),
          connectTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 75),
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    dio.interceptors.add(AuthInterceptor(storage));
  }

  final Dio dio;
}
