// lib/presentation/providers/transfer_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neobankmobile/data/models/transaction_model.dart';
import 'package:neobankmobile/data/models/transfer_request_model.dart';
import 'package:neobankmobile/domain/repositories/transfer_repository.dart';
import 'package:neobankmobile/domain/repositories/transfer_repository_impl.dart';

// Provider pour le repository
final transferRepositoryProvider = Provider<TransferRepository>((ref) {
  return TransferRepositoryImpl();
});

// Provider pour l'état du transfert
final transferProvider = StateNotifierProvider<TransferNotifier, TransferState>((ref) {
  return TransferNotifier(ref.read(transferRepositoryProvider));
});

// État du transfert
class TransferState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final String? message;
  final double? newBalance;
  final List<TransactionModel> history;

  TransferState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    this.message,
    this.newBalance,
    this.history = const [],
  });

  TransferState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    String? message,
    double? newBalance,
    List<TransactionModel>? history,
  }) {
    return TransferState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
      message: message ?? this.message,
      newBalance: newBalance ?? this.newBalance,
      history: history ?? this.history,
    );
  }
}

// Notifier
class TransferNotifier extends StateNotifier<TransferState> {
  final TransferRepository _repository;

  TransferNotifier(this._repository) : super(TransferState());

  Future<void> transfer(String destinationAccountNumber, double amount, String? description) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);

    try {
      final request = TransferRequestModel(
        destinationAccountNumber: destinationAccountNumber,
        amount: amount,
        description: description,
      );

      final response = await _repository.transfer(request);

      if (response.success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          message: response.message,
          newBalance: response.newBalance,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.message,
          isSuccess: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isSuccess: false,
      );
    }
  }

  Future<void> loadHistory({int page = 0, int size = 10}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final history = await _repository.getHistory(page: page, size: size);
      state = state.copyWith(
        isLoading: false,
        history: history,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void reset() {
    state = TransferState();
  }
}