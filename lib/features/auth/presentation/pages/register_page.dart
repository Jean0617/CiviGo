
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_config/app_config.dart';
import '../../../../config/route_config/route_paths.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends ConsumerState<RegisterPage> {
  
  final ValueNotifier<bool> valueToggle = ValueNotifier(false);

  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final repeatPasswordC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    Future.microtask((){
      ref.read(authProvider.notifier).clearError();
    });
  }

  @override
  Widget build(BuildContext context) {

    final state = ref.watch(authProvider);

    return UnFocusKeyboard(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
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
                    hintText: 'Nombre completo',
                    showBorder: false,
                    focusBorder: Colors.black12,
                    prefixIcon: const Icon(Icons.person_outline, color: Colors.black),
                    controller: nameC,
                    autoValidate: !state.succesRegister,
                  ),
                    
                  const SizedBox(height: 15),
                    
                  UITextFormField(
                    textColor: Colors.black,
                    fillColor: Colors.black.withAlpha(15),
                    hintText: 'Correo',
                    showBorder: false,
                    validateEmail: true,
                    focusBorder: Colors.black12,
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.black),
                    controller: emailC,
                    autoValidate: !state.succesRegister,
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
                    validatePasswordStrength: true,
                    controller: passwordC,
                    validEqualsText: repeatPasswordC,
                    autoValidate: !state.succesRegister,
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
                    validatePasswordStrength: true,
                    controller: repeatPasswordC,
                    validEqualsText: passwordC,
                    autoValidate: !state.succesRegister,
                  ),
                    

                  if(state.error != null)
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withAlpha(30),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        spacing: 5,
                        children: [
                          Icon(Icons.info_outline, color: Colors.red, size: 15,),
                          Flexible(child: UIText(title: state.error?.message ?? 'Error al registrar el usuario.', size: 13, color: Colors.red,)),
                        ],
                      ),
                    ),

                  if(state.succesRegister)
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(30),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        spacing: 5,
                        children: [
                          

                          Flexible(
                            child: UIText(
                              textRich: [
                                {'text': '¡Registro exitoso!', 'bold': true, 'color': Colors.green},
                                {'text': '\nTu cuenta ha sido creada correctamente. Ya puedes iniciar sesión', 'color': Colors.green, 'size': 13.0},
                              ],
                            )
                          ),

                          CircleAvatar(
                            backgroundColor: Colors.green.withAlpha(30),
                            child: Icon(Icons.check, color: Colors.green, size: 20,)
                          ),

                        ],
                      ),
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
                    isLoading: state.isSearching,
                    iconSize: 18,
                    onPressed: () async {
                      
                      if(!(_formKey.currentState?.validate()??false))return;

                      final saving = await ref.read(authProvider.notifier).signUp({
                        'name': nameC.text,
                        'email': emailC.text,
                        'password': passwordC.text
                      });

                      if(saving){
                        nameC.clear();
                        emailC.clear();
                        passwordC.clear();
                        repeatPasswordC.clear();
                      }

                    },
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
          ),
        )
      ),
    );
  }
}
