// lib/data/repositories/profile_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:neobankmobile/core/network/dio_client.dart';
import 'package:neobankmobile/data/models/password_update_request.dart';
import 'package:neobankmobile/data/models/profile_model.dart';
import 'package:neobankmobile/data/models/profile_update_request.dart';
import 'package:neobankmobile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio dio = DioClient.dio;

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await dio.get('/user/profile');
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception('Erreur de chargement: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Erreur de chargement');
      } else {
        throw Exception('Erreur réseau: ${e.message}');
      }
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileUpdateRequest request) async {
    try {
      final response = await dio.put(
        '/user/profile',
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception('Erreur de mise à jour: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Erreur de mise à jour');
      } else {
        throw Exception('Erreur réseau: ${e.message}');
      }
    }
  }

  @override
  Future<void> updatePassword(PasswordUpdateRequest request) async {
    try {
      final response = await dio.put(
        '/user/password',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Erreur de mise à jour: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Erreur de mise à jour');
      } else {
        throw Exception('Erreur réseau: ${e.message}');
      }
    }
  }
}