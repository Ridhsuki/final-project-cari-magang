import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:cari_magang_fe/data/models/internships_model/internships_model.dart';

class InternshipsService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://magangapp.ridhsuki.my.id/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  Future<Either<String, InternshipsModel>> getInternships() async {
    try {
      var response = await dio.get('/internships');
      var internships = InternshipsModel.fromMap(response.data);
      return Right(internships);
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
