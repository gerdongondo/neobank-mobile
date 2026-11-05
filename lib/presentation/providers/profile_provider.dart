// lib/presentation/providers/profile_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neobankmobile/data/models/password_update_request.dart';
import 'package:neobankmobile/data/models/profile_model.dart';
import 'package:neobankmobile/data/models/profile_update_request.dart';
import 'package:neobankmobile/data/repositories/profile_repository_impl.dart';
import 'package:neobankmobile/domain/repositories/profile_repository.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier(ref.read(profileRepositoryProvider));
});

class ProfileState {
  final bool isLoading;
  final ProfileModel? profile;
  final String? error;
  final String? successMessage;

  ProfileState({
    this.isLoading = false,
    this.profile,
    this.error,
    this.successMessage,
  });

  ProfileState copyWith({
    bool? isLoading,
    ProfileModel? profile,
    String? error,
    String? successMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _repository;

  ProfileNotifier(this._repository) : super(ProfileState());

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final profile = await _repository.getProfile();
      state = state.copyWith(isLoading: false, profile: profile);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateProfile(ProfileUpdateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final profile = await _repository.updateProfile(request);
      state = state.copyWith(
        isLoading: false,
        profile: profile,
        successMessage: 'Profil mis à jour avec succès',
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updatePassword(PasswordUpdateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _repository.updatePassword(request);
      state = state.copyWith(
        isLoading: false,
        successMessage: 'Mot de passe modifié avec succès',
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = ProfileState();
  }
}