import 'package:civigo/config/route_config/route_paths.dart';
import 'package:civigo/features/reports/presentation/providers/incidents_provider.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/container/form_no_data.dart';
import '../../../shared/widgets/data_table/action_button.dart';
import '../../../shared/widgets/data_table/column_config.dart';
import '../../../shared/widgets/data_table/ui_data_table.dart';
import '../../../shared/widgets/popup/ui_popup.dart';
import '../../../shared/widgets/text/ui_title_action.dart';
import '../../../shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:intl/intl.dart';

import '../../domain/constants.dart';

class IncidentsPage extends ConsumerStatefulWidget {
  const IncidentsPage({super.key});

  @override
  ConsumerState<IncidentsPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<IncidentsPage> {

  int totalPages = 5;
  bool isLoading = false;

  List<ColumnConfig<Map<String, dynamic>>> incidentsColumns = [
    
    ColumnConfig<Map<String, dynamic>>(
      width: 120,
      name: 'id',
      label: 'ID',
      builder: (i) => Text('Reporte ${i['id']?.toString() ?? ''}'),
    ),

    ColumnConfig<Map<String, dynamic>>(
      width: 120,
      name: 'id',
      label: 'Responsable',
      builder: (i) => Text( entidades.firstWhere((e) => e['id'] == i['designated_entity_id'])['name'] ),
    ),

    ColumnConfig<Map<String, dynamic>>(
      width: 100,
      name: 'priority',
      label: 'Prioridad',
      builder: (i) {
        
        final Map<String, dynamic> item = priority.firstWhere((e) => e['id'] == i['priority']);
        final Color color = item['id'] == 1 ? Colors.grey : item['id'] == 2 ? Colors.orange : Colors.red;
        final IconData icon = item['id'] == 3 || item['id'] == 2? Icons.warning_amber_rounded : Icons.info_outline;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 15,),
              UIText(title: item['name'], color: Colors.white),
            ],
          )
        );
      }
    ),

    ColumnConfig<Map<String, dynamic>>(
      width: 100,
      name: 'state',
      label: 'Estado',
      builder: (i) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: i['state'] == 'pendiente' ? Colors.grey.withOpacity(0.2) : Colors.green.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          i['state'] ?? 'Pendiente',
          style: TextStyle(
            color: i['state'] == 'pendiente' ? Colors.black54 : Colors.green,
          ),
        ),
      ),
    ),

    ColumnConfig<Map<String, dynamic>>(
      width: 180,
      name: 'creacion',
      label: 'Creación',
      builder: (i) => Text(DateFormat('dd-MM-yyyy hh:mm a',).format(DateTime.parse(i['created_at']))),
    ),

  ];

  @override
  void initState() {
    super.initState();

    Future.microtask((){
      ref.read(incidentsProvider.notifier).getIncidents();
    });
  }

  @override
  void didUpdateWidget(covariant IncidentsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.microtask((){
      ref.read(incidentsProvider.notifier).getIncidents();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final incidents = ref.watch(incidentsProvider);

    return UnFocusKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                UITitleAction(
                  title: 'INCIDENTES',
                  subTitle: 'Crea y supervisa tus incidencias reportadas.',
                  icon: Icons.campaign_outlined,
                  onTap:() => context.pushNamed(RoutePaths.newIncident)
                ),

                SizedBox(height: 5),

                Row(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: UITextFormField(
                        hintText: 'Buscar por identificación o nombre...',
                        borderRadius: 30,
                        focusBorder: Colors.grey.shade400,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: (){}, 
                        ),
                      ),
                    ),

                    IconButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          )
                        ),
                        padding: WidgetStatePropertyAll(EdgeInsets.all(13)),
                        backgroundColor: WidgetStatePropertyAll(Colors.black.withAlpha(20))
                      ),
                      tooltip: 'Filtros',
                      icon: Icon(Icons.filter_alt_outlined, color: Colors.black54, size: 22,),
                      onPressed: () => uIDialog(context, title: 'Filtros', message: 'Seleciione los filtros para realizar las busquedas mas precisas.'),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                incidents.isEmpty?
                FormNoData()
                :
                buildDataTable(incidents),
      
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UIDataTable<Map<String, dynamic>> buildDataTable(List<Map<String, dynamic>> data) {
    return UIDataTable<Map<String, dynamic>>(
      data: data,
      columns: incidentsColumns,
      totalPages: totalPages,
      isLoading: isLoading,
      onPageChange: (page) {
        ref.read(incidentsProvider.notifier).getIncidents();
      },
      actions: [
        ActionButton<Map<String, dynamic>>(
          icon: Icons.remove_red_eye_outlined,
          color: Colors.blueGrey,
          tooltip: 'Editar',
          onPressed: (user) {},
        ),
      ],
    );
  }

}



