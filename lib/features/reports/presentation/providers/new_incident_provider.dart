import 'package:civigo/features/reports/data/models/new_incident_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  void setImagePath(String path) {
    state = state.copyWith(incidentImagePath: path);
  }

  void reset(){
    state = NewIncidentState();
  }
}


