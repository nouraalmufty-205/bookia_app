import 'package:dio/dio.dart';

class AuthRepo {
  static Dio dio = Dio();
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "http://localhost:8000/api/login",
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "http://localhost:8000/api/register",
        data: {
          "name": username,
          "email": email,
          "password": password,
          "password_confirmation": password,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
