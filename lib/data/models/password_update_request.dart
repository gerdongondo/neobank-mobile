// lib/data/models/password_update_request.dart
class PasswordUpdateRequest {
  final String oldPassword;
  final String newPassword;

  PasswordUpdateRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}