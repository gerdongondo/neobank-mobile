// lib/data/repositories/auth_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:neobankmobile/core/network/dio_client.dart';
import 'package:neobankmobile/data/models/auth_response_model.dart';
import 'package:neobankmobile/data/models/login_request_model.dart';
import 'package:neobankmobile/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio = DioClient.dio;

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    try {
      final request = LoginRequestModel(
        email: email,
        password: password,
      );

      final response = await dio.post(
        '/auth/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception('Erreur de connexion: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Erreur de connexion');
      } else {
        throw Exception('Erreur réseau: ${e.message}');
      }
    }
  }
}