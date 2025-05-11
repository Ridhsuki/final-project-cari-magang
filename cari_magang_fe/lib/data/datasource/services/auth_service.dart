import 'package:cari_magang_fe/data/models/regist_response.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:cari_magang_fe/data/models/login_response/login_response.dart';

class AuthService {
  final dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 5),
      baseUrl: "https://magangapp.ridhsuki.my.id/api",
    ),
  );

  Future<Either<String, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      var response = await dio.post(
        '/login',
        data: {"email": email, "password": password},
      );
      var loginResponse = LoginResponse.fromMap(response.data);
      return Right(loginResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else if (e.response?.statusCode == 401) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else {
        return Left('Undhandle Error : ${e.message}');
      }
    }
  }

  Future<Either<String, RegistResponse>> regist(
    String username,
    String email,
    String password,
  ) async {
    try {
      var response = await dio.post(
        '/register',
        data: {"name": username, "email": email, "password": password},
      );
      var registResponse = RegistResponse.fromMap(response.data);
      return Right(registResponse);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else if (e.response?.statusCode == 401) {
        var errorResponse = e.response?.data['message'];
        return Left('Error : $errorResponse');
      } else {
        return Left('Undhandle Error : ${e.message}');
      }
    }
  }
}
