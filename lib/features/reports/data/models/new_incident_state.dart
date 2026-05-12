import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewIncidentState {

  final int currentStep;
  final int fullStep;
  final String state;
  final LatLng? position;
  final String priority;
  final bool happensNow;
  final DateTime? createdAt;
  final String description;
  final String incidentImagePath;
  final Map<String, dynamic> clasification;
  final Map<String, dynamic> designatedEntity;

  NewIncidentState({
    this.currentStep = 0,
    this.fullStep = 3,
    this.state = '',
    this.position,
    this.priority = '',
    this.happensNow = false,
    this.createdAt,
    this.description = '',
    this.incidentImagePath = '',
    this.clasification = const {},
    this.designatedEntity = const {},
  }); 

  NewIncidentState copyWith ({
    int? currentStep,
    String? state,
    LatLng? position,
    String? priority,
    bool? happensNow,
    DateTime? createdAt,
    String? description,
    String? incidentImagePath,
    Map<String, dynamic>? clasification,
    Map<String, dynamic>? designatedEntity,
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
      clasification: clasification ?? this.clasification,
      designatedEntity: designatedEntity ?? this.designatedEntity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "state": state,
      "position": position,
      "priority": priority,
      "happensNow": happensNow,
      "createdAt": createdAt,
      "description": description,
      "incidentImagePath": incidentImagePath,
      "clasification": clasification,
      "designatedEntity": designatedEntity,
    };
  }
}
