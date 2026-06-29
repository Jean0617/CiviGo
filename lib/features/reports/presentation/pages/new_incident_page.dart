import 'package:civigo/features/reports/presentation/providers/new_incident_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../domain/constants.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class NewIncidentPage extends ConsumerStatefulWidget {
  const NewIncidentPage({super.key});

  @override
  ConsumerState<NewIncidentPage> createState() => _FlujoCrearReporteState();
}

class _FlujoCrearReporteState extends ConsumerState<NewIncidentPage> {
  
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose(); // Importante: liberar memoria cuando salimos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final incidentState = ref.watch(newIncidentProvider);
    
    ref.listen(newIncidentProvider.select((s) => s.currentStep), (previous, next) {
      _pageController.animateToPage(
        next,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut, 
      );
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        automaticallyImplyLeading: false,
        title: UIButton(
          title: 'Cancelar',
          fontColor: Colors.black54, 
          fontSize: 14.0,
          icon: Icons.arrow_back_ios_new_rounded, 
          iconSize: 15, 
          colorIcon: Colors.black45,
          bold: true,
          borderRadius: 10,
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          onPressed: () => context.pop(),
        ),
        actions: [
          if((incidentState.currentStep+1) != incidentState.fullStep)
          Container(
            decoration: BoxDecoration(
              color: AppConfig.primaryColor.withAlpha(30),
              borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UIText(
                  title: 'Paso ${incidentState.currentStep+1} de ${incidentState.fullStep}',
                  bold: true, 
                  size: 15, 
                  color: AppConfig.primaryColor
                ),
              ],
            ),
          ),

        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: PageView(
              controller: _pageController, 
              physics: const NeverScrollableScrollPhysics(),
              children: [ 

                Step1(),

                Step2(),
                
                Step3()

              ],
            ),
          ),
          // if((incidentState.currentStep+1) != incidentState.fullStep)
          //   StepBar(
          //     currentStep: incidentState.currentStep, 
          //     fullStep: incidentState.fullStep
          //   ),

        ],
      ),
      persistentFooterDecoration: BoxDecoration(
        border: Border()
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            spacing: 5,
            children: [
          
              if(incidentState.currentStep > 1  && (incidentState.currentStep+1) != incidentState.fullStep)
              Expanded(
                child: UIButton(
                  title: "Regresar",
                  expand: true,
                  padding: EdgeInsets.symmetric(vertical: 17),
                  background: Colors.transparent,
                  bold: true,
                  fontSize: 18,
                  borderRadius: 25,
                  border: BorderSide(color: Colors.grey.shade300),
                  fontColor: Colors.black54,
                  onPressed: () {
                    ref.read(newIncidentProvider.notifier).beforeStep();
                  },
                )
              ),

              if((incidentState.currentStep+1) != incidentState.fullStep)
                Expanded(
                  child: UIButton(
                    title: (incidentState.currentStep+1) == 2? "Finalizar" : "siguiente",
                    expand: true,
                    padding: EdgeInsets.symmetric(vertical: 17),
                    background: incidentState.currentStep == 0? Colors.grey.shade100 : AppConfig.primaryColor,
                    bold: true,
                    fontSize: 18,
                    borderRadius: 25,
                    iconAlignmentStart: false,
                    isLoading: incidentState.isSaving,
                    icon: Icons.arrow_forward_ios_rounded,
                    fontColor: incidentState.currentStep == 0? Colors.grey : Colors.white,
                    onPressed: incidentState.currentStep == 0? null : () {
                      
                      if((incidentState.currentStep+1) == 2 && !(keyForm.currentState?.validate() ?? false)){
                        return;
                      }

                      if((incidentState.currentStep+1) == incidentState.fullStep){
                        context.pop();
                      }else{
                        ref.read(newIncidentProvider.notifier).saveIncident(DateTime.now());
                      }
                    },
                  )
                ),

              if((incidentState.currentStep+1) == incidentState.fullStep)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                    child: UIButton(
                      title: "Finalizar",
                      expand: true,
                      padding: EdgeInsets.symmetric(vertical: 17),
                      background: Colors.transparent,
                      bold: true,
                      fontSize: 15,
                      borderRadius: 25,
                      border: BorderSide(color: Colors.grey.shade300),
                      fontColor: Colors.black54,
                      onPressed: () {
                        context.pop(true);
                      }
                    ),
                  ),
                )
            ],
          ),
        ),
         
      ],
    );
  }
}