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

      final pendingCount = response.where(
        (e) => e['state'] == 'pending',
      ).length;

      final inProgressCount = response.where(
        (e) => e['state'] == 'in_progress',
      ).length;

      final total = response.length;

      state = state.copyWith(
        isLoading: false,
        amount: total,
        inProgress: inProgressCount,
        pending: pendingCount,
        incidents: response
      );

    } catch (e) {
      state = state.copyWith( isLoading: false );
    }
  }
}