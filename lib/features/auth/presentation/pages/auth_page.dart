
import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/auth/presentation/providers/auth_provider.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/route_config/route_paths.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../../shared/widgets/toggle/ui_switch.dart';

class AuthPage extends ConsumerStatefulWidget {
  
  const AuthPage({super.key});

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends ConsumerState<AuthPage> {

  final ValueNotifier<bool> valueToggle = ValueNotifier(false);

  final emailC = TextEditingController(text: 'nuevo5@gmail.com');
  final passwordC = TextEditingController(text: 'Under@009');
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
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
                            validateEmail: true,
                            focusBorder: Colors.black12,
                            prefixIcon: const Icon(Icons.person_outline, color: Colors.black),
                            controller: emailC,
                            onChanged: (value) => ref.read(authProvider.notifier).clearError(),
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
                            controller: passwordC,
                            onChanged: (value) => ref.read(authProvider.notifier).clearError(),
                          ),
                            
                          const SizedBox(height: 5),
                          
                          if(state.error != null)
                            Container(
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
                                  Flexible(child: UIText(title: state.error?.message ?? 'Error mensaje....', size: 13, color: Colors.red,)),
                                ],
                              ),
                            ),
                            
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
                            isLoading: state.isSearching,
                            iconSize: 18,
                            onPressed: () {
                              
                              if(!(_formKey.currentState?.validate()??false))return;

                              ref.read(authProvider.notifier).signIn({
                                'email': emailC.text,
                                'password': passwordC.text
                              });
                              
                            }
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
                            onPressed: () => context.pushNamed(RoutePaths.register),
                          ),
                      
                          const Spacer(), // empuja hacia abajo
                      
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
                ),
              );
            }
          ),
        )
      ),
    );
  }
}
