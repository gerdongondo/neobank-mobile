// lib/data/models/profile_model.dart
class ProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String accountNumber;
  final String createdAt;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.accountNumber,
    required this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'accountNumber': accountNumber,
      'createdAt': createdAt,
    };
  }
}