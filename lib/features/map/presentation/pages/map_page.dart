import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../reports/domain/constants.dart';
import '../../../reports/presentation/providers/incidents_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          UIMap(showIncident: showIncident),

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
              return !show? SizedBox.shrink() : Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.blueGrey
                    )
                  ),
                  child: ListTile(
                    // contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.withAlpha(30),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Icon(Icons.business, size: 30, color: Colors.blueGrey,)
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIText(title: 'Daño en infraestructura', bold: true, size: 13, color: Colors.black87,),
                        UIText(
                          textRich: [
                            {'text': 'Hace', 'color': Colors.black54, 'size': 10.0, },
                            {'text': '\nJusto ahora', 'color': Colors.black54, 'bold': true, 'size': 10.0},
                          ],
                        ),
                      ],
                    ),
                    subtitle: UIText(title: 'Diogenes A. Arrieta, Calle 18', size: 11,),
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

  const UIMap({super.key, this.showIncident});

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
    
    final incidents = ref.watch(incidentsProvider).map((e) => IncidentModel.fromJson(e)).toList();

    final markers = incidents.map((incident) {

      return Marker(

        markerId: MarkerId(
          incident.id.toString(),
        ),

        position: LatLng(
          incident.latitude,
          incident.longitude,
        ),

        // infoWindow: InfoWindow(
        //   title: entidades.firstWhere((e) => e['id'] == incident.entityId)['name'],
        //   snippet: incident.description,
        // ),
        onTap: () => widget.showIncident?.value = true,

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

  IncidentModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.clasification,
    required this.priority,
    required this.entityId
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
      entityId: json['designated_entity_id']
    );
  }
}
