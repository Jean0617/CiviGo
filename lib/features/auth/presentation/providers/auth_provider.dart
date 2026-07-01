import 'package:riverpod_annotation/riverpod_annotation.dart';

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

      state = state.copyWith(
        isSearching: true,
        error: () => null,
      );

      final response = await _repository.signIn(data);

      state = state.copyWith(
        user: () => response.user,
        error: () => null, 
        isLogin: true,
        isSearching: false,
      );

    } catch (e) {
      state = state.copyWith(
        isLogin: false,
        isSearching: false,
        error: () => mapAuthError(e),
      );
    }
  }

  Future<bool> signUp(Map data, {String? role}) async {
    try {

      state = state.copyWith(
        error: () => null, 
        isSearching: true,
      );

      await _repository.signUp(data, role: role);

      state = state.copyWith(
        error: () => null, 
        succesRegister: true, 
        isLogin: role != null? state.isLogin : false,
        isSearching: false
      );

      return true;

    } catch (e) {

      state = state.copyWith(
        isLogin: role != null? state.isLogin : false,
        succesRegister: false, 
        isSearching: false,
        error: () => mapAuthError(e),
      );
      
      return false;

    }
  }

  Future<void> logOut() async {
    try {

      await _repository.signOut();
  
      state = state.copyWith(
        error: () => null, 
        isLogin: false,
        user: () => null,
      );

    } catch (_) {
      print('err');
    }
  }



  void clearError(){
    state = state.copyWith(error: () => null, succesRegister: false);
  }

}