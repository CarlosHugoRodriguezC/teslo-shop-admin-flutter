import 'package:teslo_shop/features/auth/domain/domain.dart';

class UserMapper {
  static User jsonToEntity(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      roles: List<String>.from(json['roles'].map((role) => role)),
      token: json['token'] ?? '',
    );
  }
}
