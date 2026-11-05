// lib/domain/repositories/profile_repository.dart
import 'package:neobankmobile/data/models/password_update_request.dart';
import 'package:neobankmobile/data/models/profile_model.dart';
import 'package:neobankmobile/data/models/profile_update_request.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(ProfileUpdateRequest request);
  Future<void> updatePassword(PasswordUpdateRequest request);
}