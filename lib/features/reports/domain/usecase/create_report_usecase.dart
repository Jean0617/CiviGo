import 'package:civigo/features/reports/domain/entities/report_entity.dart';
import 'package:civigo/features/reports/domain/repository/report_repository.dart';

class CreateReportUsecase {
  final ReportRepository repository;

  CreateReportUsecase({required this.repository});

  Future<void> call (ReportEntity report) async{
    //aqui valido que haya escogido una clasificacion
    if(report.clasificacion.isEmpty){
      throw Exception("tiene que asignar una clasificacion");
    }
    if(report.rutaimagen.isEmpty){
      throw Exception("tiene que mandar una imagen como evidencia");
    }
    if(report.descripcion.length < 10){
      throw Exception("la descripcion es muy corta, por favor danos mas detalles");
    }

    if(report.latitud == 0 || report.longitud == 0){
      throw Exception("no hemos podido capturar tu ubicacion");
    }
    
    return await repository.createReport(report);
  }
  }