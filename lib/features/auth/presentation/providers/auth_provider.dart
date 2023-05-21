import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

import '../../domain/domain.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String errorMessage;

  AuthState({
    this.status = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''
      AuthState(
        status: $status,
        user: $user,
        errorMessage: $errorMessage,
      )
    ''';
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  AuthNotifier({required this.authRepository}) : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logoutUser(errorMessage: e.message);
    } catch (e) {
      logoutUser(errorMessage: 'Something went wrong');
    }
  }

  Future<void> registerUser(
    String email,
    String password,
    String fullName,
  ) async {}

  void checkAuthStatus() async {}

  Future<void> logoutUser({String? errorMessage}) async {
    // TODO: remove token from secure storage
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  void _setLoggedUser(User user) {
    // TODO: save token in secure storage
    state = state.copyWith(
      status: AuthStatus.authenticated,
      errorMessage: '',
      user: user,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final AuthRepository authRepository = AuthRepositoryImpl();
  return AuthNotifier(authRepository: authRepository);
});
