// lib/data/models/admin_stats_model.dart
class AdminStatsModel {
  final int totalUsers;
  final int totalTransactions;
  final double totalAmount;
  final int totalAccounts;
  final int activeUsers;
  final int blockedAccounts;

  AdminStatsModel({
    required this.totalUsers,
    required this.totalTransactions,
    required this.totalAmount,
    required this.totalAccounts,
    required this.activeUsers,
    required this.blockedAccounts,
  });

  factory AdminStatsModel.fromJson(Map<String, dynamic> json) {
    return AdminStatsModel(
      totalUsers: json['totalUsers'] ?? 0,
      totalTransactions: json['totalTransactions'] ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      totalAccounts: json['totalAccounts'] ?? 0,
      activeUsers: json['activeUsers'] ?? 0,
      blockedAccounts: json['blockedAccounts'] ?? 0,
    );
  }
}