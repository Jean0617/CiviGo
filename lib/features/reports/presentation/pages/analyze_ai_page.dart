import 'package:civigo/features/reports/presentation/providers/new_incident_provider.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

import '../../../shared/widgets/buttons/ui_button.dart';

class AnalyzeAiPage extends ConsumerStatefulWidget {

  const AnalyzeAiPage({
    super.key,
  });

  @override
  AnalyzeAiPageState createState() => AnalyzeAiPageState();
}

class AnalyzeAiPageState extends ConsumerState<AnalyzeAiPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {

        final next = await ref.read(newIncidentProvider.notifier).analyzeIncident();
        
        if(!mounted || !next)return;

        context.pop(false);
        
        ref.read(newIncidentProvider.notifier).nextStep();

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final state = ref.watch(newIncidentProvider);
    final isIncident = state.isIncident;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
    
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
               
                    OrbitAnimation(animated: isIncident),
              
                    SizedBox(height: 5,),
                
                    UIText(
                      title: isIncident? "Analizando imagen" : "No se detectó una incidencia", 
                      size: 25,
                      bold: true,
                      color: isIncident? Colors.black87 : Colors.orange,
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(isIncident? 0 : 10),
                      decoration: BoxDecoration(
                        color: isIncident? null : Colors.orange.withAlpha(20),
                        border:  isIncident? null : Border.all(color: Colors.orange.shade100),
                        borderRadius: isIncident? null : BorderRadius.circular(20),
                      ),
                      child: UIText(
                        title:  isIncident?
                        "Se está procesando la evidencia para identificar detalles relevantes y completar el reporte. Esto puede tardar unos segundos."
                        : 
                        "La imagen no muestra una incidencia que pueda ser reportada. Toma una fotografía donde el incidente sea visible y vuelve a intentarlo.",
                        size: 15,
                        // bold: true,
                        // centerText: true,
                        color: Colors.black54,
                      ),
                    ),
                    
                    if(isIncident)
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(20),
                          border: Border.all(color: Colors.blue.shade100),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.info_outline, color: Colors.blue, size: 18),
                            Flexible(
                              child: UIText(
                                title: "Seras redireccionado al siguiente paso una vez se complete el analísis.", 
                                size: 12,
                                bold: true,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
              
                    SizedBox(height: 10,),
                
                  ],
                ),
              ),
            ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: UIButton(
                title:  isIncident? "Cancelar" : "Finalizar",
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
                  Navigator.pop(context);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrbitAnimation extends StatefulWidget {
  final bool animated;

  const OrbitAnimation({
    this.animated = true,
    super.key,
  });

  @override
  State<OrbitAnimation> createState() => _OrbitAnimationState();
}

class _OrbitAnimationState extends State<OrbitAnimation> with TickerProviderStateMixin {

  late AnimationController controller;
  late AnimationController waveController;

  @override
  void initState() {
    super.initState();

    waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant OrbitAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animated) {
      if (!controller.isAnimating) {
        controller.repeat();
      }

      if (!waveController.isAnimating) {
        waveController.repeat();
      }
    } else {
      controller.stop();
      waveController.stop();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    waveController.dispose();
    super.dispose();
  }

  Widget orbitItem({
    required double angle,
    required double radius,
    required Widget child,
  }) {

    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {

        final rotation = controller.value * 2 * pi;

        final x = radius * cos(rotation + angle);
        final y = radius * sin(rotation + angle);

        return Transform.translate(
          offset: Offset(x, y),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 420,
      width: 420,
      child: Stack(
        alignment: Alignment.center,
        children: [

          /// Órbita externa
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.withAlpha(30),
              ),
            ),
          ),

          /// Órbita interna nueva
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.withAlpha(20),
              ),
            ),
          ),

          /// Centro
          AnimatedBuilder(
            animation: waveController,
            builder: (_, __) {

              final value = waveController.value;

              return Stack(
                alignment: Alignment.center,
                children: [

                  /// Onda 1
                  Transform.scale(
                    scale: 1 + (value * 1.2),
                    child: Opacity(
                      opacity: (1 - value) * 0.25,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  /// Onda 2
                  Transform.scale(
                    scale: 1 + ((value + 0.5) % 1) * 1.2,
                    child: Opacity(
                      opacity: (1 - ((value + 0.5) % 1)) * 0.18,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  /// Centro robot
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withAlpha(30),
                      border: Border.all(
                        color: Colors.blue.withAlpha(50),
                      ),
                    ),
                    child: SpinKitDancingSquare(
                      color: Colors.blue,
                      size: 35.0,
                    ),
                  ),
                ],
              );
            },
          ),

          /// Planetas
          orbitItem(
            angle: 0,
            radius: 145,
            child: miniCircle(
              // Icons.image,
              null,
              Colors.blueGrey,
              'assets/fuga_gas.png',
            ),
          ),

          orbitItem(
            angle: pi / 2,
            radius: 145,
            child: miniCircle(
              // Icons.location_on,
              null,
              Colors.blueGrey,
              'assets/poste_caido.png',
            ),
          ),

          orbitItem(
            angle: pi,
            radius: 145,
            child: miniCircle(
              // Icons.warning,
              null,
              Colors.blueGrey,
              'assets/bache.png',
            ),
          ),

          orbitItem(
            angle: pi * 1.5,
            radius: 145,
            child: miniCircle(
              // Icons.report,
              null,
              Colors.blueGrey,
              'assets/semaforo.png',
            ),
          ),

          // ÓRBITA INTERNA ICONOS

          orbitItem(
            angle: pi / 4,
            radius: 100,
            child: miniCircle(
              Icons.warning_amber_rounded,
              Colors.orange,
              'assets/fuga_gas.png',
            ),
          ),

          orbitItem(
            angle: 3 * pi / 4,
            radius: 100,
            child: miniCircle(
              Icons.info_outline,
              Colors.blue,
              'assets/semaforo.png',
            ),
          ),

          orbitItem(
            angle: 5 * pi / 4,
            radius: 100,
            child: miniCircle(
              Icons.report_gmailerrorred,
              Colors.red,
              'assets/bache.png',
            ),
          ),

          orbitItem(
            angle: 7 * pi / 4,
            radius: 100,
            child: miniCircle(
              Icons.campaign_outlined,
              Colors.blueGrey,
              'assets/poste_caido.png',
            ),
          ),

        ],
      ),
    );
  }

  Widget miniCircle(
    IconData? icon,
    Color color,
    String image,
  ) {
    return Container(
      width: icon != null? 30 : 55,
      height:  icon != null? 30 : 55,
      padding: EdgeInsets.all(icon != null? 0 : 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withAlpha(30),
      ),
      child: icon != null?
        Icon(
          icon,
          color: color,
          size: 15,
        ) 
      :
        Image.asset(image, fit: BoxFit.cover,)
    );
  }
}