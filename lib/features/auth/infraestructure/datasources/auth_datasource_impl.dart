import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/auth/infraestructure/infraestructure.dart';

import '../../domain/domain.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  @override
  Future<User> checkAuthUser(String token) async {
    try {
      final response = await dio.get(
        '/auth/check-status',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final User user = UserMapper.jsonToEntity(response.data);

      return user;
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 401) {
        throw CustomError(
          errorCode: 401,
          message: e.response?.data['message'] ?? 'Token not valid',
        );
      }

      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError(
          message: 'Check your internet connection!',
          errorCode: 504,
        );
      }

      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final User user = UserMapper.jsonToEntity(response.data);

      return user;
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 401) {
        throw CustomError(
          errorCode: 401,
          message: e.response?.data['message'] ?? 'Wrong credentials',
        );
      }

      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError(
          message: 'Check your internet connection!',
          errorCode: 504,
        );
      }

      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
