// lib/domain/repositories/auth_repository.dart
import 'package:neobankmobile/data/models/auth_response_model.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login(String email, String password);
}