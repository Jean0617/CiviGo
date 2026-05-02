

import 'package:civigo/features/reports/domain/entities/report_entity.dart';

class ReportModel {
 final String id;
 final String clasificacion;
 final String rutaimagen;
 final double latitud;
 final double longitud;
 final String descripcion;
 final String estado;
 final DateTime createdat;

  ReportModel({
    required this.id,
    required this.rutaimagen, 
    required this.latitud, 
    required this.longitud, 
    required this.descripcion, 
    required this.estado, 
    required this.createdat, 
    required this.clasificacion}); 



  factory ReportModel.fromjson (Map<String,dynamic> json){
  return ReportModel(
  id : json["id"], 
  rutaimagen : json["rutaimagen"], 
  latitud: (json["latitud"] as num).toDouble(), 
  longitud: (json["longitud"] as num).toDouble(), 
  descripcion: json["descripcion"], 
  estado: json["estado"], 
  createdat: DateTime.parse(json["createdat"]), 
  clasificacion: json ["clasificacion"]
  );
  }

  ReportEntity toentity (){
    return ReportEntity(
      id: id, 
      rutaimagen: rutaimagen, 
      latitud: latitud, 
      longitud: longitud, 
      descripcion: descripcion, 
      estado: ReportState.values.firstWhere((estados) => estados.name == estado, orElse: () => ReportState.pentiente), 
      createdat: createdat, 
      clasificacion: clasificacion
      );
  }
  
 Map<String, dynamic> toJson() {
    return {
      "id": id,
      "rutaimagen": rutaimagen,
      "latitud": latitud,
      "longitud": longitud,
      "descripcion": descripcion,
      "estado": estado, 
      "createdat": createdat.toIso8601String(), 
      "clasificacion": clasificacion,
    };
  }
  }
