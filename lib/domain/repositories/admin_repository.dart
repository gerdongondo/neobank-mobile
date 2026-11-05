// lib/domain/repositories/admin_repository.dart
import 'package:neobankmobile/data/models/admin_stats_model.dart';
import 'package:neobankmobile/data/models/admin_transaction_model.dart';
import 'package:neobankmobile/data/models/admin_user_model.dart';

abstract class AdminRepository {
  Future<AdminStatsModel> getStats();
  Future<List<AdminUserModel>> getUsers();
  Future<List<AdminTransactionModel>> getTransactions();
  Future<void> blockUser(int userId);
  Future<void> unblockUser(int userId);
}