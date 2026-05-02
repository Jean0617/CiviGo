import 'package:dio/dio.dart';

class AuthRemoteDataSource {

  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<List> fetchAll(String query) async {
    final response = await _dio.get('/endpoint/?params');
    return response.data;
  }

  Future<Map> fetchById(String id) async {
    return Future.value({});
  }

  Future<bool> create(Map data) async {
    return Future.value(true);
  }

  Future<bool> update(Map data) async {
    return Future.value(true);
  }

  Future<bool> delete(int id) async {
    return Future.value(true);
  }
  
}