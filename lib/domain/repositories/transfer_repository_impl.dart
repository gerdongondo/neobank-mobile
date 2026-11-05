// lib/data/repositories/transfer_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:neobankmobile/core/network/dio_client.dart';
import 'package:neobankmobile/data/models/transaction_model.dart';
import 'package:neobankmobile/data/models/transfer_request_model.dart';
import 'package:neobankmobile/data/models/transfer_response_model.dart';
import 'package:neobankmobile/domain/repositories/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {
  final Dio dio = DioClient.dio;

  @override
  Future<TransferResponseModel> transfer(TransferRequestModel request) async {
    try {
      print('📤 Tentative de transfert: ${request.toJson()}');

      final response = await dio.post(
        '/transfer',
        data: request.toJson(),
      );

      print('📥 Réponse reçue: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return TransferResponseModel.fromJson(response.data);
      } else {
        throw Exception('Erreur de transfert: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('❌ Erreur Dio: ${e.message}');
      if (e.response != null) {
        final errorMessage = e.response?.data['message'] ?? 'Erreur de transfert';
        throw Exception(errorMessage);
      } else {
        throw Exception('Erreur réseau: ${e.message}');
      }
    }
  }

  @override
  Future<List<TransactionModel>> getHistory({int page = 0, int size = 10}) async {
    try {
      final response = await dio.get(
        '/transfer/history',
        queryParameters: {'page': page, 'size': size},
      );

      if (response.statusCode == 200) {
        final List<dynamic> content = response.data['content'] ?? [];
        return content.map((json) => TransactionModel.fromJson(json)).toList();
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
}