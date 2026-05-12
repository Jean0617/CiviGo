import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/config/route_config/route_paths.dart';
import 'package:civigo/features/reports/presentation/providers/new_incident_provider.dart';
import 'package:civigo/features/reports/presentation/providers/step1_provider.dart';
import 'package:civigo/features/shared/widgets/buttons/ui_button.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/services/camera_service.dart';

class Step1 extends ConsumerStatefulWidget {
   
  const Step1({super.key});

  @override
  Step1State createState() => Step1State();
}

class Step1State extends ConsumerState<Step1> {

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Future.delayed(
        const Duration(milliseconds: 200),
        () => ref.read(step1Provider.notifier).setAnimate(true)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final stepState = ref.watch(step1Provider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 35, top: 10, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            
                SizedBox(
                  height: 20,
                  width: double.infinity,
                ),
            
                buildStack(stepState.animate),
            
                SizedBox(height: 20,),
            
                UIText(
                  title: "COMENCEMOS REGISTRANDO LA INCIDENCIA", 
                  size: 25,
                  bold: true,
                  centerText: true,
                  color: Colors.black,
                ),
            
                SizedBox(height: 10,),
            
                UIText(
                  title: "Toma una foto del problema. Nuestra IA lo identificará automáticamente.", 
                  size: 17,
                  centerText: true,
                  color: Colors.black87,
                ),
            
                SizedBox(height: 15,),
            
                UIButton(
                  background: AppConfig.primaryColor,
                  title: 'Abrir camara',
                  fontColor: Colors.white,
                  iconAlignmentStart: false,
                  bold: true,
                  isLoading: stepState.isOpeningCamera,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  fontSize: 16,
                  icon: Icons.camera_alt_outlined, 
                  onPressed: () async {
                    ref.read(step1Provider.notifier).setOpenCamera(true);
                    takePhotoFlow();
                  }
                ),
            
                SizedBox(height: 50,),
            
              ],
            ),
          ),
        )
      )
      
    );
  }

  Future<void> takePhotoFlow() async {
    
    final result = await CameraService.instance.takePhoto(context);

    if (result == null || !context.mounted) {
      ref.read(step1Provider.notifier).setOpenCamera(false);
      return;
    }

    ref.read(newIncidentProvider.notifier).setImagePath(result.path);
    
    if(!mounted)return;
    
    final bool? repeatPhoto = await context.pushNamed<bool>(
      RoutePaths.photoPreview,
    );

    // Repetir foto
    if (repeatPhoto == true && context.mounted) {
      await takePhotoFlow();
    }
    ref.read(step1Provider.notifier).setOpenCamera(false);
  }

  Widget buildStack(bool animate) {
    return SizedBox(
      width: double.infinity,
      height: 420,
      child: Stack(
        alignment: Alignment.center,
        children: [

          // CARD ATRÁS
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutBack,
            left: animate ? 40 : -250,
            child: Transform.rotate(
              angle: -0.25,
              child: _card(
                250,
                300,
                0,
                0,
                'assets/1.png',
                false
              ),
            ),
          ),

          // CARD MEDIO
          AnimatedPositioned(
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutBack,
            left: animate ? 120 : 250,
            child: Transform.rotate(
              angle: 0.25,
              child: _card(
                250,
                300,
                0,
                0,
                'assets/3.png',
                false
              ),
            ),
          ),

          // CARD PRINCIPAL
          AnimatedPositioned(
            // top: 20,
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInSine,
            top: animate ? 20 : 250,
            child: _card(
              250,
              370,
              0,
              0,
              'assets/2.png',
              true
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(
    double width,
    double height,
    double dx,
    double dy,
    String image,
    bool showChild,
  ) {

  return Container(
      width: width,
      height: height,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(14),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: !showChild? null
      : Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reporte ciudadano',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Reporta daños en vías, fugas, basuras o cualquier situación que afecte a tu comunidad.',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ),
    );
  }
}

