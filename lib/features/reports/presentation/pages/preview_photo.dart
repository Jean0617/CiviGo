import 'dart:io';

import 'package:civigo/features/reports/presentation/providers/new_incident_provider.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../../config/route_config/route_paths.dart';
import '../../../shared/widgets/buttons/ui_button.dart';

class PhotoPreviewPage extends ConsumerWidget {
  
  const PhotoPreviewPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final newIncidentState = ref.watch(newIncidentProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
      
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: 
                    newIncidentState.incidentImagePath.isNotEmpty?
                      Image.file(
                        File(newIncidentState.incidentImagePath),
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                  : Center(
                    child: UIText(title: 'No se pudo cargar la imagen, intentalo nuevamente.',),
                  )
                ),
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 5,),

                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green.withAlpha(30),
                    child: Icon(Icons.check, color: Colors.green, size: 30,),
                  ),

                  SizedBox(height: 5,),
              
                  UIText(
                    title: "CONFIRMACIÓN", 
                    size: 25,
                    bold: true,
                    centerText: true,
                    color: Colors.black,
                  ),
              
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.orange.withAlpha(30),
                      // border: Border.all(color: Colors.orange.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: UIText(
                      title: "Verifica que la fotografía sea clara y que muestre correctamente la situación o evidencia que deseas reportar antes de continuar.", 
                      size: 16,
                      centerText: true,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 20,),
              
                ],
              ),
            ),
      
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                spacing: 10,
                children: [
              
                  Expanded(
                    child: UIButton(
                      title: "Repetir",
                      expand: true,
                      padding: EdgeInsets.symmetric(vertical: 17),
                      background: Colors.transparent,
                      bold: true,
                      fontSize: 15,
                      borderRadius: 25,
                      icon: Icons.replay_rounded,
                      border: BorderSide(color: Colors.grey.shade300),
                      fontColor: Colors.black54,
                      onPressed: () => context.pop(true)
                    ),
                  ),
              
                  Expanded(
                    child: UIButton(
                      title: "Usar Foto",
                      expand: true,
                      padding: EdgeInsets.symmetric(vertical: 17),
                      background: AppConfig.primaryColor,
                      bold: true,
                      fontSize: 15,
                      borderRadius: 25,
                      iconAlignmentStart: false,
                      icon: Icons.arrow_forward_ios_rounded,
                      fontColor: Colors.white,
                      onPressed: () {
                        context
                          ..pop()
                          ..pushNamed(RoutePaths.analyzeIa);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}