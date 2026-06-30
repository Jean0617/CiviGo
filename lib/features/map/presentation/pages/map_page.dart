import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../reports/presentation/providers/incidents_provider.dart';
import '../../../shared/utils/date_utils.dart';

class MapIncidents extends StatefulWidget {
  
  const MapIncidents({super.key});

  @override
  MapIncidentsState createState() => MapIncidentsState();
}

class MapIncidentsState extends State<MapIncidents> {

  final List<Map> typesIncidents = [
    {'title': 'Todos', 'selected': true},
    {'title': 'Baches', 'selected': false},
    {'title': 'Basura', 'selected': false},
    {'title': 'Alumbrado', 'selected': false},
    {'title': 'Fugas', 'selected': false},
    {'title': 'Otros', 'selected': false},
  ];

  ValueNotifier<bool> showIncident = ValueNotifier(false);
  ValueNotifier<IncidentModel?> incident = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          UIMap(showIncident: showIncident, incident: incident),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
            child: UITextFormField(
              hintText: 'Buscar incidentes',
              borderRadius: 30,
              focusBorder: Colors.grey.shade400,
            ),
          ),

          Positioned(
            top: 70,
            left: 20,
            right: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 5,
                children: List.generate(typesIncidents.length, (index){
                  
                  final Map item = typesIncidents[index];

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: item['selected']? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: !item['selected']? Border.all(color: Colors.grey.shade400) : null
                    ),
                    child: Row(
                      spacing: 5,
                      children: [
                        if(item['selected'])
                          Icon(Icons.check, color: item['selected']? Colors.white : Colors.black54, size: 15,),
                        UIText(title: item['title'], color: item['selected']? Colors.white : Colors.black87, size: 11.0, bold: item['selected']),
                      ],
                    )
                  );
                })
              ),
            ),
          ),

          ValueListenableBuilder(
            valueListenable: showIncident,
            builder: (context, show, child) {
              return !show || incident.value == null? SizedBox.shrink() : Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1, blurRadius: 3
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 30,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5)
                        ),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        leading: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIText(
                              title: 'Creación', 
                              size: 15, 
                              bold: true,
                              color: const Color(0xFF424242)
                            ),
                            UIText(
                              title: DateUtilsApp.timeAgo(incident.value!.createdAt), 
                              size: 12, 
                              color: const Color(0xFF424242)
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIText(
                              title: 'Estado', 
                              size: 15, 
                              bold: true,
                              color: const Color(0xFF424242)
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: incident.value!.state == 'pending' ? Colors.grey.withAlpha(40) : Colors.green.withAlpha(40),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                incident.value!.state == 'pending'? 'Pendiente' : incident.value!.state == 'in_progress'? 'En gestión' : 'Resuelta',
                                style: TextStyle(
                                  color: incident.value!.state == 'pending' ? Colors.black87 : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UIText(
                                  title: 'Ubicación', 
                                  size: 15, 
                                  bold: true,
                                  color: const Color(0xFF424242)
                                ),
                                UIText(
                                  title: '${incident.value!.latitude.toStringAsFixed(6)}, ${incident.value!.longitude.toStringAsFixed(6)}', 
                                  size: 12, 
                                  color: const Color(0xFF424242)
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            UIText(title: 'Descripción', bold: true, size: 15, color: const Color(0xFF424242),),
                                          
                            SizedBox(height: 5),
                        
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: UIText(
                                title: incident.value!.description,
                                color: Colors.black87,
                              ),
                            ),
                        
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            UIText(title: 'EVIDENCIA:', bold: true, size: 15, color: const Color(0xFF424242),),

                            SizedBox(height: 10),
                        
                            incident.value!.incidentImageUrl.isNotEmpty ?
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white,width: 3),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5
                                    )
                                  ]
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    incident.value!.incidentImageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                        
                                    // Loading
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                        
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: SpinKitFadingCircle(color: Colors.green),
                                        ),
                                      );
                                    },
                        
                                    // Error
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox(
                                        height: 220,
                                        child: Center(
                                          child: Column(
                                            spacing: 8,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              
                                              Icon(
                                                Icons.broken_image_outlined,
                                                size: 45,
                                                color: Colors.grey,
                                              ),
                        
                                              UIText(
                                                title: 'No fue posible cargar la imagen.',
                                                color: Colors.grey,
                                              ),
                        
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ) 
                            : 
                              Center(
                                child: UIText(title: 'No se pudo cargar la imagen, intentalo nuevamente.',),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                    ],
                  ),
                )
              );
            }
          ),

        ],
      )
    );
  }
}

class UIMap extends ConsumerStatefulWidget {
  
  final ValueNotifier<bool>? showIncident;
  final ValueNotifier<IncidentModel?>? incident;

  const UIMap({super.key, this.showIncident, required this.incident});

  @override
  UIMapState createState() => UIMapState();
}

class UIMapState extends ConsumerState<UIMap> {
  late GoogleMapController mapController;

  // Definimos un conjunto de polígonos
  Set<Polygon> polygons = {};

  @override
  void initState() {
    super.initState();
    
    _setPolygons();

    Future.microtask((){
      ref.read(incidentsProvider.notifier).getIncidents();
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _setPolygons() {
    polygons.add(
      Polygon(
        polygonId: PolygonId('incidente_1'),
        points: [
          LatLng(19.4326, -99.1332),
          LatLng(19.4426, -99.1332),
          LatLng(19.4426, -99.1432),
          LatLng(19.4326, -99.1432),
        ],
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.red.withOpacity(0.15),
        consumeTapEvents: true,
        onTap: () {
          // Aquí manejas la información del incidente
          print("Incidente detectado en esta zona");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final incidents = ref.watch(incidentsProvider).incidents.map((e) => IncidentModel.fromJson(e)).toList();

    final markers = incidents.map((incident) {

      return Marker(

        markerId: MarkerId(
          incident.id.toString(),
        ),
        position: LatLng(
          incident.latitude,
          incident.longitude,
        ),
        onTap: () {
          widget.showIncident?.value = true;
          widget.incident?.value = incident;
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(

          incident.priority == 3
              ? BitmapDescriptor.hueRed

          : incident.priority == 2
              ? BitmapDescriptor.hueOrange

          : BitmapDescriptor.hueGreen,
        ),
      );

    }).toSet();

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(9.950801634752155, -75.08395675441042),
        zoom: 14,
      ),
      polygons: polygons,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
        controller.setMapStyle('''
          [

            {
              "featureType": "poi",
              "stylers": [
                { "visibility": "off" }
              ]
            },
            {
              "featureType": "transit",
              "stylers": [
                { "visibility": "off" }
              ]
            }
          ]
          ''');
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true, 
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      liteModeEnabled: false,
    );
  }
}

class IncidentModel {
  final int id;
  final double latitude;
  final double longitude;
  final String description;
  final int clasification;
  final int entityId;
  final int priority;
  final String state;
  final String createdAt;
  final String incidentImageUrl;

  IncidentModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.clasification,
    required this.priority,
    required this.entityId,
    required this.state,
    required this.createdAt,
    required this.incidentImageUrl
  });

  factory IncidentModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return IncidentModel(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      clasification: json['clasification_id'],
      priority: json['priority'],
      entityId: json['designated_entity_id'],
      state: json['state'] ?? '',
      createdAt: json['created_at'] ?? '',
      incidentImageUrl: json['incident_image_url'] ?? '',
    );
  }
}
