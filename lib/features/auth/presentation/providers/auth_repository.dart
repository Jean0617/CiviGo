
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/dio/dio_provider.dart';
import '../../data/remote/auth_data_source.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return AuthRepositoryImpl(AuthRemoteDataSource(dio));
}