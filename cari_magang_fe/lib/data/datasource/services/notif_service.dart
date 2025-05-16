import 'package:cari_magang_fe/data/datasource/local_storage/local_storage.dart';
import 'package:cari_magang_fe/data/models/delete_notif_model.dart';
import 'package:cari_magang_fe/data/models/notif_model/notif_model.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';

class NotifService {
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

  Future<Either<String, NotifModel>> getNotifications() async {
    try {
      final response = await dio.get('/notifications');
      final raw = response.data;

      if (raw is Map<String, dynamic>) {
        final notifModel = NotifModel.fromMap(raw);
        return Right(notifModel);
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

  Future<Either<String, DeleteNotifModel>> deleteNotification(
    String uuid,
  ) async {
    try {
      var response = await dio.delete('/notifications/$uuid');

      var data = DeleteNotifModel.fromMap(response.data);
      return Right(data);
    } on DioException catch (e) {
      return Left('Error: ${e.response?.data['message'] ?? e.message}');
    }
  }
}
