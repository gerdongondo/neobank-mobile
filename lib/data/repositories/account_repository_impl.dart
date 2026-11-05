// lib/data/repositories/account_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:neobankmobile/core/network/dio_client.dart';
import 'package:neobankmobile/data/models/account_model.dart';
import 'package:neobankmobile/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final Dio dio = DioClient.dio;

  @override
  Future<AccountModel> getAccount() async {
    try {
      print('📤 Récupération du compte...');

      final response = await dio.get('/account/me');

      print('📥 Réponse reçue: ${response.data}');

      if (response.statusCode == 200) {
        return AccountModel.fromJson(response.data);
      } else {
        throw Exception('Erreur de chargement: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Erreur Dio: ${e.message}');
      if (e.response != null) {
        final errorMessage = e.response?.data['message'] ?? 'Erreur de chargement';
        throw Exception(errorMessage);
      } else {
        throw Exception('Erreur réseau: ${e.message}');
      }
    }
  }
}