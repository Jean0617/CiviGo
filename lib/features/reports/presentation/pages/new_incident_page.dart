import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_title_action.dart';
import '../providers/providers.dart';
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
    
    final reporteState = ref.watch(reporteProvider);
    
    ref.listen(reporteProvider.select((s) => s.currentStep), (previous, next) {
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
          title: 'Volver',
          fontColor: Colors.black54, 
          fontSize: 14.0,
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 15, color: Colors.black45,),
          bold: true,
          borderRadius: 10,
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [

          UITitleAction(
            title: 'NUEVO INCIDENTE',
            subTitle: 'Completa la información requerida para generar un nuevo reporte.',
            padding: const EdgeInsets.only(left: 20, right: 5),
          ),

          SizedBox(height: 10),

          StepBar(
            currentStep: reporteState.currentStep, 
            fullStep: reporteState.fullStep
          ),

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
        ],
      ),
      persistentFooterDecoration: BoxDecoration(
        border: Border()
      ),
      persistentFooterButtons: [
        ButtonNextStep()
      ],
    );
  }
}