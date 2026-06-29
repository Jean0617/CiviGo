import 'package:civigo/features/reports/presentation/providers/incidents_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/incident_detail_state.dart';

part 'incident_detail_provider.g.dart';

@riverpod
class IncidentDetail extends _$IncidentDetail {
  
  @override
  IncidentDetailState build() => IncidentDetailState();

  Future<void> setIncident(int id) async {
    try {
      
      state = state.copyWith( isLoading: true );

      final incidents = ref.read(incidentsProvider).incidents; 

      final incident = incidents.firstWhere(
        (e) => e['id'] == id,
        orElse: () => <String, dynamic>{},
      );

      if (incident.isEmpty) {
        state = state.copyWith(isLoading: false);
        return;
      }

      state = state.copyWith(
        isLoading: false,
        incident: incident
      );

    } catch (e) {
      state = state.copyWith( isLoading: false );
    }
  }
}