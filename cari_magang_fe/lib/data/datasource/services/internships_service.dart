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
}
