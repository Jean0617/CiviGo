import 'package:dio/dio.dart';

import '../../../shared/domain/failures/dio_failure_mapper.dart';
import '../../domain/repository/home_repository.dart';
import '../remote/Home_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {

  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<List> fetchAll(String query) async {
    try{
      
      final response = await remote.fetchAll(query);
      return response;

    } on DioException catch (e) {
      throw mapDioError(e);
    } 
  }

  @override
  Future<Map> fetchById(int id) async {
    return Future.value({});
  }

  @override
  Future<bool> create(Map data) async {
    return Future.value(true);
  }
  
  @override
  Future<bool> update(Map data) async {
    return Future.value(true);
  }

  @override
  Future<bool> delete(int id) async {
    return Future.value(true);
  }

}