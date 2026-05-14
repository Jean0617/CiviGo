
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'db_client.g.dart';

@riverpod
SupabaseClient dbClient(Ref ref){
  return Supabase.instance.client;
}