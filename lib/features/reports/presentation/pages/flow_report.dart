import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class FlujoCrearReporte extends ConsumerStatefulWidget {
  const FlujoCrearReporte({super.key});

  @override
  ConsumerState<FlujoCrearReporte> createState() => _FlujoCrearReporteState();
}

class _FlujoCrearReporteState extends ConsumerState<FlujoCrearReporte> {
  
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
      appBar: AppBar(title: Text('Nuevo Reporte')),
      body: Column(
        children: [
       
          StepBar(
            currentStep: reporteState.currentStep + 1,
            fullStep: reporteState.fullStep,
          ),

          Expanded( 
            child: PageView(
              controller: _pageController, 
              physics: NeverScrollableScrollPhysics(), 
              children: [ 
                Step1(),
                Step2(),
                Step3()
              ],
            ),
          ),
        ],
      ),
    );
  }
}