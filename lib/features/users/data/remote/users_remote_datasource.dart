import 'package:supabase_flutter/supabase_flutter.dart';

class UserDatasource {

  final SupabaseClient client;

  UserDatasource(this.client);

  Future<List> getUsers() async {

    final response = await client.rpc(
      'get_auth_users',
    );

    return response as List;

  }

}