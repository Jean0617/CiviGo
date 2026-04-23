import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/domain/failures/app_failure.dart';
import '../../data/models/base_state.dart';
import '../../domain/repository/auth_repository.dart';
import 'auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {

  @override
  BaseState build() => BaseState();

  // Llamar al repositorio para obtener los datos
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  void fetchAll(String query) async {
    try {

      final remoteData = await _repository.fetchAll(query);

      state = state.copyWith(
        data: remoteData,
      );

    } on AppFailure catch (e) {
      state = state.copyWith(data: []);
    } catch (e) {
      state = state.copyWith(data: []);
    }
  }

}