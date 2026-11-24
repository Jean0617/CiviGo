import 'package:civigo/config/route_config/route_paths.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import 'slider.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  static const double _splitBreakpoint = 900;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {

            // Móvil: carrusel arriba y acciones abajo (diseño original)
            if (constraints.maxWidth < _splitBreakpoint) {
              return Column(
                children: [
                  Expanded(child: ElegantSlider()),
                  _actions(context),
                ],
              );
            }

            // Escritorio / tablet ancha: carrusel a la izquierda, acciones a la derecha
            return Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    child: ElegantSlider(),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 440),
                      child: _actions(context),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIText( title: AppConfig.appName, color: AppConfig.primaryColor, size: 28, bold: true),
                UIText( title: AppConfig.appLema, color: Colors.black54, size: 14),
              ],
            ),
          ),

          UIButton(
            title: 'Iniciar Sesión',
            expand: true,
            bold: true,
            background: AppConfig.primaryColor,
            fontColor: Colors.white,
            icon: Icons.login, 
            iconSize: 25,
            iconAlignmentStart: false,
            onPressed: () => context.pushNamed(RoutePaths.login),
          ),

          UIButton(
            title: 'Registrarse',
            expand: true,
            bold: true,
            background: Colors.transparent,
            fontColor: Colors.black54,
            onPressed: () => context.pushNamed(RoutePaths.register),
          )

        ],
      ),
    );
  }
}
