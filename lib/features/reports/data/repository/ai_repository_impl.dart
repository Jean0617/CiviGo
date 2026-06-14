import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repository/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {

  final SupabaseClient supabase;

  AiRepositoryImpl({
    required this.supabase
  });
  
  @override
  Future<Map<String,dynamic>> analyzeImage(
    String imageUrl,
  ) async {

    final response = await supabase.functions.invoke(
      'analyze_incident',
      body: {
        'imageUrl': imageUrl,
      },
    );

    return response.data;
  }
}