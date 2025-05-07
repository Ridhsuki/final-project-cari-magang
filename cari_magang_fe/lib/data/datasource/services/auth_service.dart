import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:cari_magang_fe/data/models/login_response/login_response.dart';

class AuthService {
  final dio = Dio(BaseOptions(connectTimeout: Duration(seconds: 5)));

  Future<Either<String, LoginResponse>> login(
    String email,
    String password,
  ) async {
    try {
      var response = await dio.post(
        'https://magangapp.ridhsuki.my.id/api/login',
        data: {"email": email, "password": password},
      );
      print(response.data);
      var dataResponse = LoginResponse.fromMap(response.data);
      return Right(dataResponse);
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
