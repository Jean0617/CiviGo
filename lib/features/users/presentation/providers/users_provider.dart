import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/auth_user_model.dart';
import 'user_repository.dart';

part 'users_provider.g.dart';

@riverpod
class Users extends _$Users {

  @override
  Future<List<AuthUserModel>> build() {
    return ref .read(userRepositoryProvider).getUsers();
  }

  Future<void> refresh() async {
    
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return ref.read(userRepositoryProvider).getUsers();
    });

  }

}