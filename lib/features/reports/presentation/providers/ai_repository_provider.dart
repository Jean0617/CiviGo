
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repository/ai_repository_impl.dart';
import '../../domain/repository/ai_repository.dart';

part 'ai_repository_provider.g.dart';

@riverpod
AiRepository aiRepository(
  Ref ref,
) {
  return AiRepositoryImpl(
    supabase: Supabase.instance.client,
  );
}