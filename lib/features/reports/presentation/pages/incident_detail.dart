import 'package:civigo/features/shared/utils/date_utils.dart';
import 'package:civigo/features/shared/widgets/buttons/ui_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/dropdown/ui_dropdown_button.dart';
import '../../../shared/widgets/radiogroups/ui_radiogroup.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../domain/constants.dart';
import '../providers/detail/incident_detail_provider.dart';

class IncidentDetailPage extends ConsumerStatefulWidget {
  final int id;
  const IncidentDetailPage({
    super.key,
    required this.id
  });

  @override
  IncidentDetailPageState createState() => IncidentDetailPageState();
}

class IncidentDetailPageState extends ConsumerState<IncidentDetailPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask((){
      ref.read(incidentDetailProvider.notifier).setIncident(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final state = ref.watch(incidentDetailProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        title: UIButton(
          icon: Icons.arrow_back_ios,
          title: 'Regresar',
          fontSize: 13,
          iconSize: 15,
          padding: EdgeInsets.only(right: 10),
          onPressed: () => context.pop(),
        ),
      ),
      body: state.isLoading?
        Column(
          children: [
            SpinKitFadingCircle(color: Colors.green,),
            UIText(
              title: 'Cargando...',
            )
          ],
        )
      : !state.isLoading && state.incident.isEmpty?
        Row(
          children: [
            Icon(Icons.info_outline, size: 15, color: Colors.blueGrey),
            Flexible(
              child: UIText(
                title: 'No se pudo cargar la incidencia.',
              ),
            )
          ],
        )
      :
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              
                  UIText(
                    title: "DETALLES DEL REPORTE", 
                    size: 20,
                    bold: true,
                    color: Colors.black,
                  ),
                    
                  ListTile(
                    contentPadding: EdgeInsets.only(top: 10, right: 20),
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
                          title: DateUtilsApp.formatDateTime(state.incident['created_at']), 
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
                            color: state.incident['state'] == 'pending' ? Colors.grey.withAlpha(40) : Colors.green.withAlpha(40),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            state.incident['state'] == 'pending'? 'Pendiente' : state.incident['state'] == 'in_progress'? 'En gestión' : 'Resuelta',
                            style: TextStyle(
                              color: state.incident['state'] == 'pending' ? Colors.black87 : Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: UIText(title: 'Clasificación', bold: true, size: 15, color: const Color(0xFF424242),),
                    ),
                    subtitle: Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        UIDropdownButton<Map>(
                          hintText: 'Seleccione...',
                          items: clasificaciones,
                          autoValidate: true,
                          value: state.incident['clasification_id'] == null
                            ? null
                            : clasificaciones.firstWhere(
                            (e) => e['id'] == state.incident['clasification_id']
                          ),
                          itemBuilder: (item) => item['name'] ?? ''
                        ),

                      ],
                    ),
                  ),
              
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: UIText(title: 'Entidad encargada', bold: true, size: 15, color: const Color(0xFF424242),),
                    ),
                    subtitle: Column(
                      spacing: 5,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        UIDropdownButton<Map>(
                          hintText: 'Seleccione...',
                          items: entidades,
                          autoValidate: true,
                          value: state.incident['designated_entity_id'] == null
                            ? entidades[0]
                            : entidades.firstWhere(
                                (e) => e['id'] == state.incident['designated_entity_id']
                              ),
                          itemBuilder: (item) => item['name'] ?? '',
                        ),

                      ],
                    ),
                  ),
              
                  SizedBox(height: 20),
              
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      spacing: 15,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                  
                        UIText(title: '¿Ocurre ahora?', bold: true, size: 15, color: const Color(0xFF424242)),
                  
                        Expanded(
                          child: UIRadioGroup<String>(
                            items: const ['No','Si'],
                            value: state.incident['happens_now']? 'Si': 'No',
                            direction: Axis.horizontal,
                            labelBuilder: (item) => item,
                            onChanged: (value) {}
                          ),
                        ),
                    
                      ],
                    ),
                  ),
              
                  SizedBox(height: 20),
              
                  UIText(title: 'Prioridad del reporte', bold: true, size: 15, color: const Color(0xFF424242),),
                  SizedBox(height: 5),
              
                  Row(
                    spacing: 10,
                    children: List.generate(priority.length, (i){
                      
                      final Map<String, dynamic> item = priority[i];
                      final bool isSelected = state.incident['priority'] == item['id'];
                  
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected? item['color'] : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: isSelected? null : Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            spacing: 2,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item['icon'], size: 20, color: isSelected? Colors.white : Colors.grey.shade500,),
                              UIText(title: '${item['name']}', bold: true, size: 16, color: isSelected? Colors.white : Colors.grey.shade500,),
                            ],
                          )
                        ),
                      );
                    })
                  ),
              
                  SizedBox(height: 20),
              
                  UIText(title: 'Descripción', bold: true, size: 15, color: const Color(0xFF424242),),
                  
                  SizedBox(height: 5),
              
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: UIText(
                      title: state.incident['description'] ?? '...',
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 20,),

                  UIText(title: 'EVIDENCIA:', bold: true, size: 15, color: const Color(0xFF424242),),
                  SizedBox(height: 10),

                  state.incident['incident_image_url'].toString().isNotEmpty ?
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
                          state.incident['incident_image_url'],
                          width: double.infinity,
                          fit: BoxFit.cover,

                          // Loading
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return Center(
                              child: SpinKitFadingCircle(color: Colors.green),
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
                  SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        )
      )
      
    );
  }
}


      