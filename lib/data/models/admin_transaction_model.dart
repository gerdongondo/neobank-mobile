// lib/data/models/admin_transaction_model.dart
class AdminTransactionModel {
  final int id;
  final String reference;
  final String sourceAccountNumber;
  final String destinationAccountNumber;
  final double amount;
  final String type;
  final String status;
  final String? description;
  final String transactionDate;
  final String sourceUserEmail;
  final String destinationUserEmail;
  final String sourceUserName;
  final String destinationUserName;

  AdminTransactionModel({
    required this.id,
    required this.reference,
    required this.sourceAccountNumber,
    required this.destinationAccountNumber,
    required this.amount,
    required this.type,
    required this.status,
    this.description,
    required this.transactionDate,
    required this.sourceUserEmail,
    required this.destinationUserEmail,
    required this.sourceUserName,
    required this.destinationUserName,
  });

  factory AdminTransactionModel.fromJson(Map<String, dynamic> json) {
    return AdminTransactionModel(
      id: json['id'] ?? 0,
      reference: json['reference'] ?? '',
      sourceAccountNumber: json['sourceAccountNumber'] ?? '',
      destinationAccountNumber: json['destinationAccountNumber'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      description: json['description'],
      transactionDate: json['transactionDate'] ?? '',
      sourceUserEmail: json['sourceUserEmail'] ?? '',
      destinationUserEmail: json['destinationUserEmail'] ?? '',
      sourceUserName: json['sourceUserName'] ?? '',
      destinationUserName: json['destinationUserName'] ?? '',
    );
  }
}