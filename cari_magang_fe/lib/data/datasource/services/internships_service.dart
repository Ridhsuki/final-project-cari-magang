import 'package:cari_magang_fe/data/datasource/local_storage/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:cari_magang_fe/data/models/internships_model/internships_model.dart';

class InternshipsService {
  final dio = Dio();

  Future<Either<String, InternshipsModel>> getInternships() async {
    dio.options = BaseOptions(
      baseUrl: 'https://magangapp.ridhsuki.my.id/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getToken()}',
      },
    );

    try {
      final response = await dio.get('/internships');

      final raw = response.data;
      // print('Response data: $raw');

      if (raw is Map<String, dynamic>) {
        final internshipModel = InternshipsModel.fromMap(raw);
        return Right(internshipModel);
      } else {
        return Left("Expected response as Map but got ${raw.runtimeType}");
      }
    } on DioException catch (e) {
      final errorResponse = e.response?.data['message'] ?? e.message;
      return Left('$errorResponse');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}
