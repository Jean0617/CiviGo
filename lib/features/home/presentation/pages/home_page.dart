
import 'package:civigo/config/route_config/route_paths.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import 'slider.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
          
            Expanded(child: ElegantSlider()),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIText( title: AppConfig.appName, color: Colors.blueGrey, size: 28, bold: true),
                        UIText( title: AppConfig.appLema, color: Colors.black54, size: 14),
                      ],
                    ),
                  ),
                    
                  UIButton(
                    title: 'Reportar caso',
                    expand: true,
                    bold: true,
                    background: Colors.blue,
                    fontColor: Colors.white,
                    icon: Icon(Icons.report_gmailerrorred, color: Colors.white, size: 25,),
                  ),
                    
                  UIButton(
                    title: 'Iniciar Sesión',
                    expand: true,
                    bold: true,
                    background: Colors.transparent,
                    fontColor: Colors.black54,
                    onPressed: () => context.pushNamed(RoutePaths.login),
                  )
              
                ],
              ),
            ),
        ],
        ),
      ),
    );
  }
}
