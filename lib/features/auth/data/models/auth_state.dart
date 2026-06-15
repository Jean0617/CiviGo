import 'package:civigo/features/shared/domain/app_error.dart';

class AuthState {

  final bool isLogin;
  final bool isSearching; 
  final AppError? error;

  AuthState({
    this.isSearching = false,
    this.error,
    this.isLogin = false
  });

  AuthState copyWith({
    bool? isLogin,
    bool? isSearching,
    Function()? error
  }) {
    return AuthState(
      isLogin: isLogin ?? this.isLogin,
      isSearching: isSearching ?? this.isSearching,
      error: error != null? error() : this.error
    );
  }

}
