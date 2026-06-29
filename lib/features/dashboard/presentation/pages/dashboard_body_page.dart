

import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/route_config/route_paths.dart';
import '../../../map/presentation/pages/map_page.dart';
import '../../../reports/domain/constants.dart';
import '../../../reports/presentation/providers/incidents_provider.dart';
import '../../../shared/utils/date_utils.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../widgets/card_activities.dart';

class DashboardBody extends ConsumerStatefulWidget {
  
  const DashboardBody({super.key});

  @override
  DashboardBodyState createState() => DashboardBodyState();
}

class DashboardBodyState extends ConsumerState<DashboardBody> {
  final List<Map> recentlyActivities = [
    {'title': 'Tuberia de agua reventada', 'subtitle': 'Calle la paz, #45-87', 'icon': Icons.water_drop_outlined, 'createdAt': '2 Días', 'color': Colors.blue},
    {'title': 'Luminaria fundida', 'subtitle': 'Barrio chile, C 16 - 45', 'icon': Icons.lightbulb, 'createdAt': '1 Hora', 'color': Colors.yellow},
    {'title': 'Fuga de gas inflamable', 'subtitle': 'San Victorino, C 12 - 24', 'icon': Icons.whatshot_rounded, 'createdAt': '25 Min', 'color': Colors.orange},
    {'title': 'Bache en vía principal', 'subtitle': 'El progreso, C 15 - 11', 'icon': Icons.remove_road_rounded, 'createdAt': '10 Días', 'color': Colors.blueGrey},
  ];

  @override
  Widget build(BuildContext context) {
    
    final state = ref.watch(incidentsProvider);
    final user = ref.watch(authProvider).user;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 13),
        children: [

          buildWelcome(user),

          CardActivities(
            title: 'MIS REPORTES',
            amount: state.amount,
            pending: state.pending,
            inProgress: state.inProgress,
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

          if(state.incidents.isEmpty)
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey.shade100),
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey.withAlpha(30)
              ),
              child: Row(
                spacing: 5,
                children: [
                  Icon(Icons.campaign_outlined, color: Colors.blueGrey,),
                  Flexible(
                    child: UIText(
                      title: 'Aún no has realizado ningún reporte. Cuando lo hagas, podrás ver la información desde esta sección.',
                      size: 13,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),

          Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: List.generate(state.incidents.length, (index) {
                  
                  final Map item = state.incidents[index];
                  
                  final classification = clasificaciones.firstWhere((e) => e['id'] == item['clasification_id']);
                  
                  final priority = item['priority'] == 1? Colors.blue : item['priority'] == 2? Colors.orange : Colors.red;
                  
                  final description = item['description'].toString().length > 60? item['description'].toString().substring(0, 60) : item['description'].toString();

                  return ListTile(
                    // contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        color: priority.withAlpha(50),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Icon(Icons.campaign_outlined, size: 30, color: priority,)
                    ),
                    title: UIText(title: '${classification['name']}', bold: true, size: 13, color: Colors.black87,),
                    subtitle: UIText(title: '$description...', size: 11,),
                    trailing:  UIText(
                      textRich: [
                        {'text': 'Hace', 'color': Colors.black54, 'size': 10.0, },
                        {'text': '\n${DateUtilsApp.timeAgo(item['created_at'])}', 'color': Colors.black54, 'bold': true, 'size': 10.0},
                      ],
                    ),
                    shape: (index+1) == state.incidents.length? null : Border(
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

  Widget buildWelcome(User? user) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: UIText(
        textRich: [
          {'text': '${getGreeting()},', 'color': Colors.black87, 'bold': true, 'size': 22.0, },
          {'text': '${user?.identities?[0].identityData?['name'] ?? 'Usuario'} 👋', 'color': AppConfig.primaryColor, 'bold': true, 'size': 22.0},
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
              child: UIMap()
            )
          )
        ],
      ),
    );
  }
}


