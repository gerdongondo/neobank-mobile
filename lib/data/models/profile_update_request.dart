// lib/data/models/profile_update_request.dart
class ProfileUpdateRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  ProfileUpdateRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
  }
}