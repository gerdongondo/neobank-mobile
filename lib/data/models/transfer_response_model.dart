// lib/data/models/transfer_response_model.dart
class TransferResponseModel {
  final String message;
  final bool success;
  final String? transactionReference;
  final double? newBalance;
  final String? transactionId;

  TransferResponseModel({
    required this.message,
    required this.success,
    this.transactionReference,
    this.newBalance,
    this.transactionId,
  });

  factory TransferResponseModel.fromJson(Map<String, dynamic> json) {
    return TransferResponseModel(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      transactionReference: json['transactionReference'],
      newBalance: json['newBalance'] != null 
          ? (json['newBalance'] as num).toDouble() 
          : null,
      transactionId: json['transactionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'transactionReference': transactionReference,
      'newBalance': newBalance,
      'transactionId': transactionId,
    };
  }
}