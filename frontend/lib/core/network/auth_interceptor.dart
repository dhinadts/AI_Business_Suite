import 'package:dio/dio.dart';

import '../storage/app_local_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.storage);

  final AppLocalStorage storage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
