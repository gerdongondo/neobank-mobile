// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:neobankmobile/data/local/secure_storage.dart';

class DioClient {
  static const String baseUrl = 'http://localhost:8080/api';
  static const int timeout = 30000;

  static Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: timeout),
        receiveTimeout: const Duration(milliseconds: timeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptor pour le token
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 🔥 AJOUTER CETTE CONDITION : Ne pas ajouter le token pour les endpoints d'auth
          final isAuthEndpoint = options.path.contains('/auth/login') || 
                                 options.path.contains('/auth/register');
          
          if (!isAuthEndpoint) {
            final token = await SecureStorage.getToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await SecureStorage.clear();
          }
          return handler.next(error);
        },
      ),
    );

    // Logger
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print(object),
      ),
    );

    return dio;
  }
}