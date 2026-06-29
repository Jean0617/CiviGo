import 'package:civigo/features/reports/data/models/incidents_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'incident_repository_provider.dart';

part 'incidents_provider.g.dart';

@riverpod
class Incidents extends _$Incidents {
  
  @override
  IncidentsState build() => IncidentsState();

  Future<void> getIncidents() async {
    try {
      
      state = state.copyWith( isLoading: true );

      final repo = ref.read(incidentRepositoryProvider); 
      final response = await repo.getIncidents();

      state = state.copyWith(
        isLoading: false,
        incidents: response
      );

    } catch (e) {
      state = state.copyWith( isLoading: false );
    }
  }
}