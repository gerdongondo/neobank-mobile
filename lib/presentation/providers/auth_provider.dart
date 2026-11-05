// lib/presentation/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neobankmobile/data/local/secure_storage.dart';
import 'package:neobankmobile/data/repositories/auth_repository_impl.dart';
import 'package:neobankmobile/domain/repositories/auth_repository.dart';

// Provider pour le repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});

// Provider pour l'état d'authentification
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

// État d'authentification
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? token;
  final String? userEmail;
  final String? userName;
  final String? role;  // ← AJOUTER
  final String? error;

  AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.token,
    this.userEmail,
    this.userName,
    this.role,  // ← AJOUTER
    this.error,
  });

  // 🔥 AJOUTER UN GETTER POUR isAdmin
  bool get isAdmin => role == 'ADMIN';

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? token,
    String? userEmail,
    String? userName,
    String? role,  // ← AJOUTER
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
      role: role ?? this.role,  // ← AJOUTER
      error: error ?? this.error,
    );
  }
}

// Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState());

  // Login
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _authRepository.login(email, password);

      if (response.success) {
        // Sauvegarder le token
        await SecureStorage.saveToken(response.token);
        await SecureStorage.saveUser(response.toJson().toString());

        // 🔥 DÉTERMINER LE RÔLE
        final userRole = (response.email == 'admin@neobank.com' ||
                response.email == 'superadmin@neobank.com')
            ? 'ADMIN'
            : 'USER';

        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          token: response.token,
          userEmail: response.email,
          userName: '${response.firstName} ${response.lastName}',
          role: userRole,  // ← AJOUTER
          error: null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.message,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Logout
  Future<void> logout() async {
    await SecureStorage.clear();
    state = AuthState();
  }

  // Vérifier si l'utilisateur est déjà connecté
  Future<void> checkAuthStatus() async {
    final token = await SecureStorage.getToken();
    final userData = await SecureStorage.getUser();

    if (token != null && userData != null) {
      try {
        state = state.copyWith(
          isAuthenticated: true,
          token: token,
        );
      } catch (e) {
        // Erreur de parsing
      }
    }
  }
}