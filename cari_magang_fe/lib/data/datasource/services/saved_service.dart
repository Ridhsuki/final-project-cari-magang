import 'package:cari_magang_fe/data/datasource/local_storage/local_storage.dart';
import 'package:cari_magang_fe/data/models/saved_model/saved_model.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class SavedService {
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

  Future<Either<String, SavedModel>> getSaved() async {
    try {
      var response = await dio.get('/favorites');

      final raw = response.data;

      if (raw is Map<String, dynamic>) {
        final savedModel = SavedModel.fromMap(raw);
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

  Future<Either<String, String>> updateSaved(int internshipId) async {
    try {
      var response = await dio.post(
        '/favorites',
        data: {"internship_id": internshipId},
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return Right(response.data['message']);
      } else {
        return Left('Gagal: ${response.data['message']}');
      }
    } on DioException catch (e) {
      final errorResponse = e.response?.data['message'] ?? e.message;
      return Left('Request error: $errorResponse');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}
