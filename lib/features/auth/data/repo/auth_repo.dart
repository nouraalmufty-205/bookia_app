import 'package:bookia/core/networking/api_endpoints.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/core/utils/app_constants.dart';
import 'package:bookia/services/local/local_helper.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  static Dio dio = Dio();
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );
      if (response?.statusCode == 200) {
        String? token = response?.data["data"]["token"];
        saveToken(token);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiEndpoints.register,
        data: {
          "name": username,
          "email": email,
          "password": password,
          "password_confirmation": password,
        },
      );
      if (response?.statusCode == 200) {
        String? token = response?.data["data"]["token"];
        saveToken(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static saveToken(String? token) async {
    await LocalHelper.prfes?.setString(AppConstants.UserToken, token ?? "");
  }
}
