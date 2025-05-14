import 'package:cari_magang_fe/data/datasource/local_storage/local_storage.dart';
import 'dart:io';
import 'package:cari_magang_fe/data/local_storage/local_storage.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:cari_magang_fe/data/models/profile_model/profile_model.dart';

class ProfileService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://magangapp.ridhsuki.my.id/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: {'Authorization': 'Bearer ${LocalStorage.getToken()}'},
    ),
  );

  Future<Either<String, ProfileModel>> getUser() async {
    try {
      var response = await dio.get('/profile');

      var profile = ProfileModel.fromMap(response.data);

      return Right(profile);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        var errorResponse = e.response?.data['message'];
        return Left('Error: $errorResponse');
      } else if (e.response?.statusCode == 401) {
        var errorResponse = e.response?.data['message'];
        return Left('Unauthorized: $errorResponse');
      } else {
        return Left('Unhandled Error: ${e.message}');
      }
    }
  }

  Future<Either<String, String>> updateProfile({
    required String name,
    required String placeOfBirth,
    required String dateOfBirth,
    required String address,
    required String education,
    File? profilePicture,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'place_of_birth': placeOfBirth,
        'date_of_birth': dateOfBirth,
        'address': address,
        'education': education,
      });

      if (profilePicture != null) {
        String fileName = profilePicture.path.split('/').last;
        formData.files.add(
          MapEntry(
            'profile_picture',
            await MultipartFile.fromFile(
              profilePicture.path,
              filename: fileName,
            ),
          ),
        );
      }

      var response = await dio.post('/profile', data: formData);
      return Right(response.data['message'] ?? 'Profile berhasil di perbarui');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response?.data['message'] ?? 'Gagal memperbarui Profile');
      } else {
        return Left('Connection error: ${e.message}');
      }
    }
  }
}
