import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewIncidentState {

  final int currentStep;
  final int fullStep;
  final String state;
  final LatLng? position;
  final int priority;
  final String? happensNow;
  final DateTime? createdAt;
  final String description;
  final String incidentImagePath;
  final String incidentImageUrl;
  final int? clasification;
  final int? designatedEntity;
  final bool isSaving;
  final bool isIncident;

  final String aiCategory;
  final String aiEntity;

  NewIncidentState({
    this.currentStep = 0,
    this.fullStep = 3,
    this.state = 'pending',
    this.position,
    this.priority = 3,
    this.happensNow = 'Si',
    this.createdAt,
    this.description = '',
    this.incidentImagePath = '',
    this.incidentImageUrl = '',
    this.clasification,
    this.designatedEntity,
    this.isSaving = false,
    this.isIncident = true,

    this.aiCategory='',
    this.aiEntity='',
  }); 

  NewIncidentState copyWith ({
    int? currentStep,
    String? state,
    LatLng? position,
    int? priority,
    String? happensNow,
    DateTime? createdAt,
    String? description,
    String? incidentImagePath,
    String? incidentImageUrl,
    int? clasification,
    int? designatedEntity,
    bool? isSaving,
    bool? isIncident,

    String? aiCategory,
    String? aiEntity,
  }){
    return NewIncidentState(
      currentStep: currentStep ?? this.currentStep,
      state: state ?? this.state,
      position: position ?? this.position,
      priority: priority ?? this.priority,
      happensNow: happensNow ?? this.happensNow,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      incidentImagePath: incidentImagePath ?? this.incidentImagePath,
      incidentImageUrl: incidentImageUrl ?? this.incidentImageUrl,
      clasification: clasification ?? this.clasification,
      designatedEntity: designatedEntity ?? this.designatedEntity,
      isSaving: isSaving ?? this.isSaving,
      isIncident: isIncident ?? this.isIncident,

      aiCategory: aiCategory ?? this.aiCategory,
      aiEntity: aiEntity ?? this.aiEntity,
    );
  }

  Map<String, dynamic> toJson({required String imageUrl, DateTime? createdAt}) {
    return {
      "state": state,
      "latitude": position?.latitude ?? 0.0,
      "longitude": position?.longitude ?? 0.0,
      "priority": priority,
      "happens_now": happensNow == 'Si',
      "created_at": createdAt?.toIso8601String(),
      "description": description,
      "incident_image_url": imageUrl,
      "clasification_id": clasification,
      "designated_entity_id": designatedEntity,
      "isIncident": isIncident
    };
  }
}
