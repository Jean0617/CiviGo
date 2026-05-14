import 'dart:io';

import 'package:civigo/features/reports/presentation/providers/new_incident_provider.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/dropdown/ui_dropdown_button.dart';
import '../../../shared/widgets/radiogroups/ui_radiogroup.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../domain/constants.dart';

class Step2 extends ConsumerStatefulWidget {

  const Step2({super.key});

  @override
  Step2State createState() => Step2State();
}

class Step2State extends ConsumerState<Step2> {

  @override
  Widget build(BuildContext context) {
    
    final newIncidentState = ref.watch(newIncidentProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              
                  SizedBox(height: 20,),
              
                  UIText(
                    title: "VAMOS A CLASIFICAR EL REPORTE ", 
                    size: 25,
                    bold: true,
                    color: Colors.black,
                  ),
                    
                  SizedBox(height: 20),
                  
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: UIText(title: 'Clasificación', bold: true, size: 15, color: const Color(0xFF424242), isRequired: true,),
                    ),
                    subtitle: UIDropdownButton<Map>(
                      hintText: 'Seleccione...',
                      items: clasificaciones,
                      value: newIncidentState.clasification == null
                        ? clasificaciones[0]
                        : clasificaciones.firstWhere(
                        (e) => e['id'] == newIncidentState.clasification,
                      ),
                      itemBuilder: (item) => item['name'] ?? '',
                      onChanged: (value) => ref.read(newIncidentProvider.notifier).setClasification(value?['id'],)
                    ),
                  ),
              
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: UIText(title: 'Entidad encargada', bold: true, size: 15, color: const Color(0xFF424242), isRequired: true,),
                    ),
                    subtitle: UIDropdownButton<Map>(
                      hintText: 'Seleccione...',
                      items: entidades,
                      value: newIncidentState.designatedEntity == null
                        ? entidades[0]
                        : entidades.firstWhere(
                            (e) => e['id'] == newIncidentState.designatedEntity
                          ),
                      itemBuilder: (item) => item['name'] ?? '',
                      onChanged: (value) => ref.read(newIncidentProvider.notifier).setDesignatedEntity(value?['id'])
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
                            value: newIncidentState.happensNow,
                            direction: Axis.horizontal,
                            labelBuilder: (item) => item,
                            onChanged: (value) => ref.read(newIncidentProvider.notifier).setHappensNow(value!)
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
                      final bool isSelected = newIncidentState.priority == item['id'];
                  
                      return GestureDetector(
                        onTap: () => ref.read(newIncidentProvider.notifier).setPriority(item['id']),
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
              
                  UIText(title: 'Descripción', isRequired: true, bold: true, size: 15, color: const Color(0xFF424242),),
                  SizedBox(height: 5),
              
                  UITextFormField(
                    maxLines: 7,
                    hintText: 'Descripción',
                    initialValue: newIncidentState.description,
                    onChanged: (value) => ref.read(newIncidentProvider.notifier).setDescription(value),
                  ),

                  SizedBox(height: 20,),

                  UIText(title: 'EVIDENCIA:', isRequired: true, bold: true, size: 15, color: const Color(0xFF424242),),
                  SizedBox(height: 10),

                  newIncidentState.incidentImagePath.isNotEmpty ?
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
                        child: Image.file(
                          File(newIncidentState.incidentImagePath),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
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


      