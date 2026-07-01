import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  
  Future<AuthResponse> signUp(Map data, { String? role});

  Future<AuthResponse> signIn(Map data);

  Future<void> signOut();

  User? get currentUser;

}