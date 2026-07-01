
import 'package:civigo/features/users/data/remote/users_remote_datasource.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repository/user_repository_impl.dart';
import '../../domain/user_repository.dart';

part 'user_repository.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(
    UserDatasource(Supabase.instance.client)
  );
}