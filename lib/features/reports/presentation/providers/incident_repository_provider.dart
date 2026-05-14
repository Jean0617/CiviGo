import 'package:civigo/core/db/db_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repository/incidents_reposirory_impl.dart';

part 'incident_repository_provider.g.dart';

@riverpod
IncidentRepository incidentRepository(Ref ref) {
  final db = ref.read(dbClientProvider);
  return IncidentRepository(db);
}