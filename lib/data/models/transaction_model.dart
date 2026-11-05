// lib/data/models/transaction_model.dart
class TransactionModel {
  final int id;
  final String reference;
  final double amount;
  final String type;
  final String status;
  final String? description;
  final String transactionDate;

  TransactionModel({
    required this.id,
    required this.reference,
    required this.amount,
    required this.type,
    required this.status,
    this.description,
    required this.transactionDate,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? 0,
      reference: json['reference'] ?? '',
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      description: json['description'],
      transactionDate: json['transactionDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'amount': amount,
      'type': type,
      'status': status,
      'description': description,
      'transactionDate': transactionDate,
    };
  }
}