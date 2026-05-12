
import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/route_config/route_paths.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../../shared/widgets/toggle/ui_switch.dart';

class AuthPage extends StatelessWidget {
  
  AuthPage({super.key});

  final ValueNotifier<bool> valueToggle = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return UnFocusKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                          
                        const SizedBox(height: 30,),
                          
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          minTileHeight: 0,
                          minVerticalPadding: 0,
                          dense: true,
                          title: const UIText(
                            title: "Bienvenido", 
                            size: 40, bold: true, color: AppConfig.primaryColor
                          ),
                          subtitle: const UIText(
                            title: "Ingresa tus datos para iniciar sesión.", 
                            size: 13, color: Colors.black
                          ),
                        ),
                          
                        const SizedBox(height: 50),
                          
                        UITextFormField(
                          fillColor: Colors.black.withAlpha(15),
                          hintText: 'Usuario',
                          textColor: Colors.black,
                          showBorder: false,
                          focusBorder: Colors.black12,
                          prefixIcon: const Icon(Icons.person_outline, color: Colors.black),
                        ),
                          
                        const SizedBox(height: 15),
                          
                        UITextFormField(
                          fillColor: Colors.black.withAlpha(15),
                          hintText: 'Contraseña',
                          textColor: Colors.black,
                          showBorder: false,
                          isPassword: true,
                          focusBorder: Colors.black12,
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                        ),
                          
                        const SizedBox(height: 5),
                          
                        Row(
                          children: [
                          
                            const UIText(
                              title: "Recordar datos", 
                              size: 14, color: Colors.black
                            ),
                          
                            ValueListenableBuilder(
                              valueListenable: valueToggle,
                              builder: (context, value, child) {
                                return UISwitch(
                                  scale: 0.7,
                                  activeTrackColor: Colors.blueGrey,
                                  inactiveThumbColor: Colors.black54,
                                  inactiveTrackColor: Colors.white,
                                  active: value,
                                  onChanged: (val) => valueToggle.value = val,
                                );
                              }
                            ),
                          ],
                        ),
                          
                        const SizedBox(height: 30),
                          
                        UIButton(
                          title: 'Ingresar',
                          expand: true,
                          bold: true,
                          background: AppConfig.primaryColor,
                          fontColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          iconAlignmentStart: false,
                          icon: Icons.login, 
                          iconSize: 18,
                          onPressed: () => context.go(RoutePaths.dashboardPath),
                        ),
                          
                        UIButton(
                          textRich: [
                            {'text': '¿No tienes cuenta? ', 'color': Colors.black54},
                            {'text': 'Registrate.', 'color': AppConfig.primaryColor, 'bold': true}
                          ],
                          expand: true,
                          bold: true,
                          background: Colors.transparent,
                          fontColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          onPressed: () => context.pushReplacementNamed(RoutePaths.register),
                        ),
                    
                        const Spacer(), // empuja hacia abajo
                    
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: UIText(
                              title: 'Regresar',
                              bold: true,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                          
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        )
      ),
    );
  }
}
