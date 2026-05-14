

import 'package:civigo/config/app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/route_config/route_paths.dart';
import '../../../map/presentation/pages/map_page.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../widgets/card_activities.dart';

class DashboardBody extends StatelessWidget {
  
  DashboardBody({super.key});

  final List<Map> recentlyActivities = [
    {'title': 'Tuberia de agua reventada', 'subtitle': 'Calle la paz, #45-87', 'icon': Icons.water_drop_outlined, 'createdAt': '2 Días', 'color': Colors.blue},
    {'title': 'Luminaria fundida', 'subtitle': 'Barrio chile, C 16 - 45', 'icon': Icons.lightbulb, 'createdAt': '1 Hora', 'color': Colors.yellow},
    {'title': 'Fuga de gas inflamable', 'subtitle': 'San Victorino, C 12 - 24', 'icon': Icons.whatshot_rounded, 'createdAt': '25 Min', 'color': Colors.orange},
    {'title': 'Bache en vía principal', 'subtitle': 'El progreso, C 15 - 11', 'icon': Icons.remove_road_rounded, 'createdAt': '10 Días', 'color': Colors.blueGrey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 13),
        children: [

          buildWelcome(),

          CardActivities(
            title: 'MIS REPORTES',
            amount: 1,
            pending: 1,
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const UIText(title: "Actividad reciente", size: 15, bold: true),
              InkWell(
                onTap: () => context.go(RoutePaths.incidentsPath),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const UIText(title: "Ver todo", size: 12, color: AppConfig.primaryColor, bold: true),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 10, color: AppConfig.primaryColor),
                    const SizedBox(width: 5)
                  ],
                ),
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: List.generate(recentlyActivities.length, (index) {
                  
                  final Map item = recentlyActivities[index];

                  return ListTile(
                    // contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        color: item['color'].withAlpha(30),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Icon(item['icon'], size: 30, color: item['color'],)
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIText(title: '${item['title']}', bold: true, size: 13, color: Colors.black87,),
                        UIText(
                          textRich: [
                            {'text': 'Hace', 'color': Colors.black54, 'size': 10.0, },
                            {'text': '\n${item['createdAt']}', 'color': Colors.black54, 'bold': true, 'size': 10.0},
                          ],
                        ),
                      ],
                    ),
                    subtitle: UIText(title: '${item['subtitle']}', size: 11,),
                    shape: index == 4? null : Border(
                      bottom: BorderSide(color: Colors.black12)
                    )
                  );
                }
              ),
            ),
          ),

          buildMapIncidents(context),
          
          SizedBox(height: 50)
 
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.campaign_outlined, color: Colors.white,),
        onPressed: (){},
      ),
    );
  }


  Widget buildWelcome() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: UIText(
        textRich: [
          {'text': '${getGreeting()},', 'color': Colors.black87, 'bold': true, 'size': 22.0, },
          {'text': 'Jean 👋', 'color': AppConfig.primaryColor, 'bold': true, 'size': 22.0},
          {'text': '\nAquí tienes un resumen de tu actividad hoy.', 'color': Colors.black87,'size': 13.0},
        ],
        size: 30,
        bold: true,
        color: Colors.blueGrey,
      ),
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return 'Buenos días';
    if (hour < 18) return 'Buenas tardes';
    return 'Buenas noches';
  }

  Widget buildMapIncidents(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 20),
      child: Column(
        children: [
      
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const UIText(title: "Mapa de incidencias", size: 15, bold: true),
              InkWell(
                onTap: () => context.go(RoutePaths.mapIncidentsPath),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const UIText(title: "Ver mapa", size: 12, color: AppConfig.primaryColor, bold: true),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 10, color: AppConfig.primaryColor),
                    const SizedBox(width: 5)
                  ],
                ),
              ),
            ],
          ),
      
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox.shrink() //UIMap()
            )
          )
        ],
      ),
    );
  }

}


