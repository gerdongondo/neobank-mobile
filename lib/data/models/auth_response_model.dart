// lib/data/models/auth_response_model.dart
class AuthResponseModel {
  final String token;
  final String message;
  final bool success;
  final String email;
  final String firstName;
  final String lastName;

  AuthResponseModel({
    required this.token,
    required this.message,
    required this.success,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  // Conversion manuelle depuis JSON
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'] ?? '',
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  // Conversion manuelle en JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'message': message,
      'success': success,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}