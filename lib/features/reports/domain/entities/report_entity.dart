 
enum ReportState {
  pentiente,
  enviado
}

class ReportEntity {
 final String id;
 final String clasificacion;
 final String rutaimagen;
 final double latitud;
 final double longitud;
 final String descripcion;
 final ReportState estado;
 final DateTime createdat;

  ReportEntity({
    required this.id,
    required this.rutaimagen, 
    required this.latitud, 
    required this.longitud, 
    required this.descripcion, 
    required this.estado, 
    required this.createdat, 
    required this.clasificacion}); 

}