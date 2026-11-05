// lib/data/repositories/admin_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:neobankmobile/core/network/dio_client.dart';
import 'package:neobankmobile/data/models/admin_stats_model.dart';
import 'package:neobankmobile/data/models/admin_transaction_model.dart';
import 'package:neobankmobile/data/models/admin_user_model.dart';
import 'package:neobankmobile/domain/repositories/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final Dio dio = DioClient.dio;

  @override
  Future<AdminStatsModel> getStats() async {
    try {
      final response = await dio.get('/admin/stats');
      if (response.statusCode == 200) {
        return AdminStatsModel.fromJson(response.data);
      } else {
        throw Exception('Erreur: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Erreur réseau');
    }
  }

  @override
  Future<List<AdminUserModel>> getUsers() async {
    try {
      final response = await dio.get('/admin/users');
      if (response.statusCode == 200) {
        final List<dynamic> content = response.data['content'] ?? [];
        return content.map((json) => AdminUserModel.fromJson(json)).toList();
      } else {
        throw Exception('Erreur: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Erreur réseau');
    }
  }

  @override
  Future<List<AdminTransactionModel>> getTransactions() async {
    try {
      final response = await dio.get('/admin/transactions');
      if (response.statusCode == 200) {
        final List<dynamic> content = response.data['content'] ?? [];
        return content
            .map((json) => AdminTransactionModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Erreur: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Erreur réseau');
    }
  }

  @override
  Future<void> blockUser(int userId) async {
    try {
      await dio.put('/admin/users/$userId/block');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Erreur réseau');
    }
  }

  @override
  Future<void> unblockUser(int userId) async {
    try {
      await dio.put('/admin/users/$userId/unblock');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Erreur réseau');
    }
  }
}