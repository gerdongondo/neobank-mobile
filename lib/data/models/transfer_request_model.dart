// lib/data/models/transfer_request_model.dart
class TransferRequestModel {
  final String destinationAccountNumber;
  final double amount;
  final String? description;

  TransferRequestModel({
    required this.destinationAccountNumber,
    required this.amount,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'destinationAccountNumber': destinationAccountNumber,
      'amount': amount,
      'description': description,
    };
  }

  factory TransferRequestModel.fromJson(Map<String, dynamic> json) {
    return TransferRequestModel(
      destinationAccountNumber: json['destinationAccountNumber'] ?? '',
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
    );
  }
}