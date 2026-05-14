import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'incident_repository_provider.dart';

part 'incidents_provider.g.dart';

@riverpod
class Incidents extends _$Incidents {
  
  @override
  List<Map<String, dynamic>> build() => [];

  Future<void> getIncidents() async {
    try {
 
      final repo = ref.read(incidentRepositoryProvider); 
      final response = await repo.getIncidents();

      state = response;

    } catch (e) {
      print(e.toString());
    }
  }
}