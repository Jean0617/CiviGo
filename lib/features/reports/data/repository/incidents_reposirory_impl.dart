import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class IncidentRepository {

  final SupabaseClient _supabase;

  IncidentRepository(this._supabase);

  Future<String> uploadImage(File file) async {
    try {

      final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _supabase.storage
          .from('incidencias')
          .upload(
            fileName,
            file,
          );

      final publicUrl =
          _supabase.storage
              .from('incidencias')
              .getPublicUrl(fileName);

      return publicUrl;

    } catch (e) {
      throw Exception(
        'No se pudo subir la imagen',
      );
    }
  }

  Future<void> createIncident(Map<String, dynamic> data) async {
    try {
      
      await _supabase.from('incidencias').insert(data);

    } catch (e) {
      throw Exception(
        'No se pudo crear la incidencia',
      );
    }
  }

  Future<List<Map<String, dynamic>>> getIncidents() async {
    try {

      final response =
          await _supabase
              .from('incidencias')
              .select().order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception(
        'No se pudieron cargar las incidencias',
      );
    }
  }

  Future<void> deleteIncident(int id) async {
    try {

      await _supabase.from('incidencias').delete().eq('id', id);

    } catch (e) {
      throw Exception(
        'No se pudo eliminar la incidencia',
      );
    }
  }

  Future<void> updateIncidentState({
    required int id,
    required String state,
  }) async {
    try {
      await _supabase
          .from('incidencias')
          .update({'state': state}).eq('id', id);

    } catch (e) {
      throw Exception(
        'No se pudo actualizar el estado',
      );
    }
  }
}