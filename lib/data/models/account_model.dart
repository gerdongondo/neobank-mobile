// lib/data/models/account_model.dart
class AccountModel {
  final String accountNumber;
  final double balance;
  final String currency;
  final String status;
  final String firstName;
  final String lastName;
  final String email;

  AccountModel({
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      accountNumber: json['accountNumber'] ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? 'XOF',
      status: json['status'] ?? 'ACTIVE',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountNumber': accountNumber,
      'balance': balance,
      'currency': currency,
      'status': status,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}