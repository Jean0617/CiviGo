import 'dart:convert';
import 'dart:io';

import 'package:civigo/features/reports/data/models/new_incident_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'ai_repository_provider.dart';
import 'incident_repository_provider.dart';

part 'new_incident_provider.g.dart';

@riverpod
class NewIncident extends _$NewIncident {
  
  @override
  NewIncidentState build() => NewIncidentState();

  void nextStep (){
    if(state.currentStep < state.fullStep - 1){
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void beforeStep (){
    if(state.currentStep > 0){
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void setLocation(LatLng value) {
    state = state.copyWith(position: value);
  }

  void setImagePath(String path) {
    state = state.copyWith(incidentImagePath: path);
  }

  void setClasification(int value) {
    state = state.copyWith(clasification: value);
  }

  void setDesignatedEntity(int value) {
    state = state.copyWith(designatedEntity: value);
  }

  void setHappensNow(String value) {
    state = state.copyWith(happensNow: value);
  }

  void setPriority(int value) {
    state = state.copyWith(priority: value);
  }

  void setDescription(String value) {
    state = state.copyWith(description: value);
  }

  Future<bool> saveIncident(DateTime date) async {
    try {
      
      state = state.copyWith(isSaving: true);

      final repo = ref.read(incidentRepositoryProvider); 
      // final imageUrl = await repo.uploadImage(File(state.incidentImagePath));

      await repo.createIncident(state.toJson(createdAt: date, imageUrl: state.incidentImageUrl));

      state = state.copyWith(isSaving: false);

      nextStep();

      return true;

    } catch (e) {
      state = state.copyWith(isSaving: false); 
      return false;
    }
  }

  Future<bool> analyzeIncident() async {
    
    state = state.copyWith( isSaving: true );

    try {

      final repo = ref.read( incidentRepositoryProvider );
      final aiRepo = ref.read( aiRepositoryProvider );

      final imageUrl = await repo.uploadImage(
        File(
          state.incidentImagePath,
        ),
      );

      final result = await aiRepo.analyzeImage(
        imageUrl,
      );

      final aiResponse = jsonDecode(
        result['response'],
      );

      state = state.copyWith(
        incidentImageUrl: imageUrl,
        aiCategory: aiResponse['categoria'],
        aiEntity: aiResponse['entidad'],
        priority: aiResponse['riesgo'],
        description: aiResponse['descripcion'],
        isSaving: false,
        isIncident: aiResponse['is_incident'] ?? false
      );

      return aiResponse['is_incident'] ?? false;

    } catch (e) {

      state = state.copyWith( isSaving: false );
      return false;
      
    }
  }

  void reset(){
    state = NewIncidentState();
  }
}


