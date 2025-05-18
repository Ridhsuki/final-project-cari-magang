import 'package:cari_magang_fe/data/datasource/local_storage/local_storage.dart';
import 'package:cari_magang_fe/data/models/applied_status_model/applied_status_model.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class AppliedStatusService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://magangapp.ridhsuki.my.id/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getToken()}',
      },
    ),
  );

  Future<Either<String, AppliedStatusModel>> getAppliedHistory() async {
    try {
      var response = await dio.get('/user/my-applications');

      final raw = response.data;

      if (raw is Map<String, dynamic>) {
        final savedModel = AppliedStatusModel.fromMap(raw);
        return Right(savedModel);
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
