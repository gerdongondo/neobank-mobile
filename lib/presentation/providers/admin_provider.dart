// lib/presentation/providers/admin_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neobankmobile/data/models/admin_stats_model.dart';
import 'package:neobankmobile/data/models/admin_transaction_model.dart';
import 'package:neobankmobile/data/models/admin_user_model.dart';
import 'package:neobankmobile/domain/repositories/admin_repository.dart';
import 'package:neobankmobile/domain/repositories/admin_repository_impl.dart';

// Providers
final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  return AdminRepositoryImpl();
});

final adminStatsProvider = FutureProvider<AdminStatsModel>((ref) async {
  return ref.read(adminRepositoryProvider).getStats();
});

final adminUsersProvider = FutureProvider<List<AdminUserModel>>((ref) async {
  return ref.read(adminRepositoryProvider).getUsers();
});

final adminTransactionsProvider =
    FutureProvider<List<AdminTransactionModel>>((ref) async {
  return ref.read(adminRepositoryProvider).getTransactions();
});