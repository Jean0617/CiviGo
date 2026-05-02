import 'package:civigo/features/reports/domain/repository/report_repository.dart';

class DeleteReportUsecase {
  final ReportRepository repository;

  DeleteReportUsecase({required this.repository});
 
 Future<bool> call (String id) async{
 return await repository.deleteReport(id);
 }
}