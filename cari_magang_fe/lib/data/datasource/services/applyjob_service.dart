import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:cari_magang_fe/data/models/applyjob_model/applyjob_model.dart';
import 'package:cari_magang_fe/data/datasource/local_storage/local_storage.dart';

class ApplyjobService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://magangapp.ridhsuki.my.id/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${LocalStorage.getToken()}',
      },
    ),
  );

  Future<Either<String, ApplyjobModel>> applyJob({
    // required String internshipId,
    required File cv, // full url atau filename tergantung API backend
    required String fullName,
    required String dateOfBirth,
    required String address,
    required String education,
    File? certificate, // opsional
  }) async {
    try {
      FormData formData = FormData.fromMap({
        // 'internship_id': internshipId,
        'cv': cv,
        'full_name': fullName,
        'date_of_birth': dateOfBirth,
        'address': address,
        'education': education,
        if (certificate != null) 'certificate': certificate,
      });

      var response = await dio.post('/applications', data: formData);
      return Right(response.data['message'] ?? 'Berhasil aplly Internsips');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response?.data['message'] ?? 'Gagal aplly Internsips');
      } else {
        return Left('Connection error: ${e.message}');
      }
    }
  }
}
