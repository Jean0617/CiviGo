
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../../config/route_config/route_paths.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_text.dart';

class RegisterPage extends StatelessWidget {
  
  RegisterPage({super.key});

  final ValueNotifier<bool> valueToggle = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return UnFocusKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
      
                const SizedBox(height: 30,),
      
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  minTileHeight: 0,
                  minVerticalPadding: 0,
                  dense: true,
                  title: const UIText(
                    title: "Crear cuenta", 
                    size: 40, bold: true, color: AppConfig.primaryColor
                  ),
                  subtitle: const UIText(
                    title: "Completa los campos para registrar tus datos en CiviGo.", 
                    size: 13, color: Colors.black
                  ),
                ),
      
                const SizedBox(height: 50),
      
                UITextFormField(
                  textColor: Colors.black,
                  fillColor: Colors.black.withAlpha(15),
                  hintText: 'Usuario',
                  showBorder: false,
                  focusBorder: Colors.black12,
                  prefixIcon: const Icon(Icons.person_outline, color: Colors.black),
                ),
      
                const SizedBox(height: 15),
      
                UITextFormField(
                  textColor: Colors.black,
                  fillColor: Colors.black.withAlpha(15),
                  hintText: 'Correo',
                  showBorder: false,
                  focusBorder: Colors.black12,
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
                ),
      
                const SizedBox(height: 15),
      
                UITextFormField(
                  textColor: Colors.black,
                  fillColor: Colors.black.withAlpha(15),
                  hintText: 'Contraseña',
                  showBorder: false,
                  isPassword: true,
                  focusBorder: Colors.black12,
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                ),
      
                const SizedBox(height: 15),
      
                UITextFormField(
                  textColor: Colors.black,
                  fillColor: Colors.black.withAlpha(15),
                  hintText: 'Repetir Contraseña',
                  showBorder: false,
                  isPassword: true,
                  focusBorder: Colors.black12,
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                ),
      
                const SizedBox(height: 30),
      
                UIButton(
                  title: 'Registrame',
                  expand: true,
                  bold: true,
                  background: AppConfig.primaryColor,
                  fontColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  iconAlignmentStart: false,
                  icon: Icons.person_add_alt, 
                  colorIcon: Colors.white, 
                  iconSize: 18,
                ),
      
                UIButton(
                  textRich: [
                    {'text': '¿Ya tienes cuenta? ', 'color': Colors.black54},
                    {'text': 'Ingresa.', 'color': AppConfig.primaryColor, 'bold': true}
                  ],
                  expand: true,
                  bold: true,
                  background: Colors.transparent,
                  fontColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  onPressed: () => context.pushReplacementNamed(RoutePaths.login),
                )
      
              ],
            ),
          ),
        )
      ),
    );
  }
}
