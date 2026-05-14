import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // UIMap(),

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

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.black26
                )
              ),
              child: ListTile(
                // contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.orange.withAlpha(30),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Icon(Icons.whatshot_rounded, size: 30, color: Colors.orange,)
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIText(title: 'Fuga de gas inflamable', bold: true, size: 13, color: Colors.black87,),
                    UIText(
                      textRich: [
                        {'text': 'Hace', 'color': Colors.black54, 'size': 10.0, },
                        {'text': '\n25 Min', 'color': Colors.black54, 'bold': true, 'size': 10.0},
                      ],
                    ),
                  ],
                ),
                subtitle: UIText(title: 'San Victorino, C 12 - 24', size: 11,),
              ),
            )
          ),

        ],
      )
    );
  }
}

// class UIMap extends StatefulWidget {
//   const UIMap({super.key});

//   @override
//   State<UIMap> createState() => _UIMapState();
// }

// class _UIMapState extends State<UIMap> {
//   late GoogleMapController mapController;

//   // Definimos un conjunto de polígonos
//   Set<Polygon> polygons = {};

//   @override
//   void initState() {
//     super.initState();
//     _setPolygons();
//   }

//   @override
//   void dispose() {
//     mapController.dispose();
//     super.dispose();
//   }

//   void _setPolygons() {
//     polygons.add(
//       Polygon(
//         polygonId: PolygonId('incidente_1'),
//         points: [
//           LatLng(19.4326, -99.1332),
//           LatLng(19.4426, -99.1332),
//           LatLng(19.4426, -99.1432),
//           LatLng(19.4326, -99.1432),
//         ],
//         strokeWidth: 2,
//         strokeColor: Colors.red,
//         fillColor: Colors.red.withOpacity(0.15),
//         consumeTapEvents: true,
//         onTap: () {
//           // Aquí manejas la información del incidente
//           print("Incidente detectado en esta zona");
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       initialCameraPosition: CameraPosition(
//         target: LatLng(9.950801634752155, -75.08395675441042), // Ciudad de México
//         zoom: 12,
//       ),
//       polygons: polygons,
//       onMapCreated: (GoogleMapController controller) {
//         mapController = controller;
//       },
//       // Habilita controles similares a los de tu imagen
//       myLocationEnabled: true,
//       myLocationButtonEnabled: false,
//       zoomControlsEnabled: true, 
//       gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//         Factory<OneSequenceGestureRecognizer>(
//           () => EagerGestureRecognizer(),
//         ),
//       },
//       liteModeEnabled: false,
//     );
//   }
// }