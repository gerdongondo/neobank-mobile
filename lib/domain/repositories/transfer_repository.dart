// lib/domain/repositories/transfer_repository.dart
import 'package:neobankmobile/data/models/transfer_request_model.dart';
import 'package:neobankmobile/data/models/transfer_response_model.dart';
import 'package:neobankmobile/data/models/transaction_model.dart';

abstract class TransferRepository {
  Future<TransferResponseModel> transfer(TransferRequestModel request);
  Future<List<TransactionModel>> getHistory({int page, int size});
}