import 'package:civigo/features/shared/domain/app_error.dart';
import 'package:civigo/features/shared/presentation/providers/ui_alerts_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

import '../../../shared/domain/failures/app_failure.dart';
import '../../../shared/presentation/failure_mapper_sb.dart';
import '../../data/models/auth_state.dart';
import '../../domain/repository/auth_repository.dart';
import 'auth_repository.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {

  @override
  AuthState build() => AuthState();

  // Llamar al repositorio para obtener los datos
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  Future<void> signIn(Map data) async {
    try {

      final response = await _repository.signIn(data);

      state = state.copyWith(error: () => null, isLogin: true);

    } catch (e) {
      state = state.copyWith(
        isLogin: false,
        error: () => mapAuthError(e),
      );
    }
  }

  Future<void> signUp(Map data) async {
    try {

      final response = await _repository.signUp(data);
  
      state = state.copyWith(error: () => null, isLogin: true);

    } catch (e) {
      state = state.copyWith(
        isLogin: false,
        error: () => mapAuthError(e),
      );
    }
  }

  Future<void> logOut() async {
    try {

      await _repository.signOut();
  
      state = state.copyWith(
        error: () => null, 
        isLogin: false
      );

    } catch (_) {
      print('err');
    }
  }



  void clearError(){
    state = state.copyWith(error: () => null);
  }

}