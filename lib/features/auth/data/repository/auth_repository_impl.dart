import 'package:civigo/features/dashboard/presentation/models/menu_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final SupabaseClient _supabase;

  AuthRepositoryImpl(this._supabase);
  
  @override
  Future<AuthResponse> signUp(Map data, { String? role}) async {

    final response = await _supabase.auth.signUp(
      email: data['email'],
      password: data['password'],
      data: {
        'name': data['name'],
        'role': role ?? UserRole.citizen.name,
        if(data['entity_id'] != null)
          'entity_id': data['entity_id'],
      }
    );

    return response;
  }

  @override
  Future<AuthResponse> signIn(Map data) async {
    return await _supabase.auth.signInWithPassword(
      email: data['email'],
      password: data['password'],
    );
  }

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  User? get currentUser {
    return _supabase.auth.currentUser;
  }

}