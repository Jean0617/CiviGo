import 'package:civigo/features/reports/domain/entities/report_entity.dart';

abstract class ReportRepository {
  Future<ReportEntity> getReport (String id);
  Future<void> createReport (ReportEntity report);
  Future<List<ReportEntity>> getListReports ();
  Future<bool> deleteReport (String id);
}