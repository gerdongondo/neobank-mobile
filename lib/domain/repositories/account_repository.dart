// lib/domain/repositories/account_repository.dart
import 'package:neobankmobile/data/models/account_model.dart';

abstract class AccountRepository {
  Future<AccountModel> getAccount();
}