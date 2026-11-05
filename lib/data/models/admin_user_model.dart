// lib/data/models/admin_user_model.dart
class AdminUserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final String? accountNumber;
  final double balance;
  final String status;
  final String createdAt;

  AdminUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    this.accountNumber,
    required this.balance,
    required this.status,
    required this.createdAt,
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) {
    return AdminUserModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'USER',
      accountNumber: json['accountNumber'],
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 'NO_ACCOUNT',
      createdAt: json['createdAt'] ?? '',
    );
  }
}