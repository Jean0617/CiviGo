import 'package:civigo/features/reports/domain/entities/report_entity.dart';
import 'package:civigo/features/reports/domain/repository/report_repository.dart';

class GetReportUsecase{
 final ReportRepository repository;

  GetReportUsecase({required this.repository});

 Future<List<ReportEntity>> call () async{
 return await repository.getListReports();
 }
}