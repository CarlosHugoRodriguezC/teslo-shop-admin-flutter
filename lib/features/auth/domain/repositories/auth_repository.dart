import '../domain.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);

  Future<User> register(String email, String password, String fullName);

  Future<User> checkAuthUser(String token);
}
