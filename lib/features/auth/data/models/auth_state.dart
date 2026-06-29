import 'package:civigo/features/shared/domain/app_error.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState {

  final bool isLogin;
  final bool isSearching; 
  final bool succesRegister;
  final User? user;
  final AppError? error;

  AuthState({
    this.isSearching = false,
    this.error,
    this.user,
    this.isLogin = false,
    this.succesRegister = false,
  });

  AuthState copyWith({
    bool? isLogin,
    bool? isSearching,
    bool? succesRegister,
    Function()? user,
    Function()? error
  }) {
    return AuthState(
      isLogin: isLogin ?? this.isLogin,
      isSearching: isSearching ?? this.isSearching,
      succesRegister: succesRegister ?? this.succesRegister,
      user: user != null? user() : this.user,
      error: error != null? error() : this.error
    );
  }

}
