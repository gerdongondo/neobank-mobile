// lib/presentation/providers/account_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neobankmobile/data/models/account_model.dart';
import 'package:neobankmobile/data/repositories/account_repository_impl.dart';
import 'package:neobankmobile/domain/repositories/account_repository.dart';

// Provider pour le repository
final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepositoryImpl();
});

// Provider pour l'état du compte
final accountProvider = StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  return AccountNotifier(ref.read(accountRepositoryProvider));
});

// État du compte
class AccountState {
  final bool isLoading;
  final AccountModel? account;
  final String? error;

  AccountState({
    this.isLoading = false,
    this.account,
    this.error,
  });

  AccountState copyWith({
    bool? isLoading,
    AccountModel? account,
    String? error,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      account: account ?? this.account,
      error: error ?? this.error,
    );
  }
}

// Notifier
class AccountNotifier extends StateNotifier<AccountState> {
  final AccountRepository _repository;

  AccountNotifier(this._repository) : super(AccountState());

  Future<void> loadAccount() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final account = await _repository.getAccount();
      state = state.copyWith(
        isLoading: false,
        account: account,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void reset() {
    state = AccountState();
  }
}