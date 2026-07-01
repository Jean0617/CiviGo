import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/dashboard/presentation/models/menu_item_model.dart';
import 'package:civigo/features/reports/domain/constants.dart';
import 'package:civigo/features/shared/domain/app_error.dart';
import 'package:civigo/features/shared/domain/app_error_entity.dart';
import 'package:civigo/features/shared/presentation/providers/ui_alerts_provider.dart';
import 'package:civigo/features/shared/widgets/dropdown/ui_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../../shared/widgets/textformfield/ui_text_form_field.dart';

class NewUserPage extends ConsumerStatefulWidget {
  const NewUserPage({super.key});

  @override
  RegisterStepperPageState createState() => RegisterStepperPageState();
}

class RegisterStepperPageState extends ConsumerState<NewUserPage> {
  
  final PageController _pageController = PageController();

  int currentStep = 0;
  final _formKeyUser = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final repeatPasswordC = TextEditingController();
  final ValueNotifier<UserRole> role = ValueNotifier(UserRole.citizen);
  final ValueNotifier<int?> entityId = ValueNotifier(null);

  void nextStep() {
    if (currentStep < 2) {
      setState(() => currentStep++);

      _pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);

      _pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leadingWidth: 20,
        automaticallyImplyLeading: false,
        actionsPadding: EdgeInsets.only(right: 10),
        title: UIButton(
          title: 'Volver',
          fontColor: Colors.black54, 
          fontSize: 14.0,
          icon: Icons.arrow_back_ios_new_rounded, 
          iconSize: 15, 
          colorIcon: Colors.black45,
          bold: true,
          borderRadius: 10,
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
          onPressed: () => context.pop(),
        ),
        toolbarHeight: 60,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [

          ListTile(
            visualDensity: VisualDensity.compact,
            dense: true,
            minTileHeight: 0,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            title: UIText( 
              title: 'NUEVO USUARIO', color: Colors.black87, size: 25.0,
              bold: true,
            ),
            subtitle: UIText(title: 'Completa el formulario para registrar el nuevo usuario dentro del sistema.', size: 12, color: Colors.black87,),
            // trailing: 
            
          ),

          /// INDICADOR PASOS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              children: List.generate(3, (index) {
                final isActive = currentStep >= index;

                return Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppConfig.primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }),
            ),
          ),

          /// PAGE VIEW
          Expanded(
            child: Form(
              key: _formKeyUser,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Step1(nameC: nameC, role: role, entityId: entityId),
                  Step2(emailC: emailC, passwordC: passwordC, repeatPasswordC: repeatPasswordC),
                  Step3(),
                ],
              ),
            ),
          ),

          /// BOTONES
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [

                /// ATRAS
                if (currentStep > 0 && currentStep <= 1)
                  Expanded(
                    child: UIButton(
                      border: BorderSide(color: Colors.grey.shade300, width: 2),
                      onPressed: previousStep,
                      title: 'Atrás',
                    ),
                  ),

                if (currentStep > 0)
                  const SizedBox(width: 10),

                /// SIGUIENTE
                Expanded(
                  child: UIButton(
                    background: AppConfig.primaryColor,
                    fontColor: Colors.white,
                    bold: true,
                    onPressed: () async {

                      if (currentStep == 2) {
                        context.pop();
                      }
                      
                      if(!(_formKeyUser.currentState?.validate()??false))return;

                      if (currentStep == 1) {

                        final saving = await ref.read(authProvider.notifier).signUp(
                          {
                            'name': nameC.text,
                            'email': emailC.text,
                            'password': passwordC.text,
                            if(entityId.value != null)
                              'entity_id': entityId.value
                          }, 
                          role: role.value.name
                        );

                        if(saving){
                          nextStep();
                        } else {
                          ref.read(uiAlertsProvider.notifier).show(
                            AppErrorEntity(type: AppErrorType.warning, message: 'No se pudo crear el usuario')
                          );
                        }
                        
                        return;
                      }

                      nextStep();
                    },
                    title: currentStep == 1? 'Finalizar' : currentStep == 2? 'Cerrar' : 'Siguiente',
                    
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// STEP 1
class Step1 extends StatelessWidget {

  final TextEditingController nameC;
  final ValueNotifier<UserRole> role;
  final ValueNotifier<int?> entityId;

  const Step1({
    super.key,
    required this.nameC,
    required this.role,
    required this.entityId
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Información personal',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          UITextFormField(
            title: 'Nombre completo',
            hintText: 'Ej: Juan andres perez...',
            borderRadius: 15,
            focusBorder: Colors.grey.shade400,
            controller: nameC,
            autoValidate: true,
          ),

          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: UIText(title: 'Rol', bold: true, size: 13, color: const Color(0xFF424242)),
            ),
            subtitle: UIDropdownButton<UserRole>(
              hintText: 'Seleccione...',
              items: UserRole.values,
              value: role.value,
              itemBuilder: (item) => item.name,
              onChanged: (value) {
                role.value = value!;
                entityId.value = null;
              },
            ),
          ),


          ValueListenableBuilder(
            valueListenable: role,
            builder: (context, value, child) {
              return value.name != UserRole.entity.name? SizedBox.shrink() : ListTile(
                contentPadding: EdgeInsets.zero,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: UIText(title: 'Entidad encargada', bold: true, size: 13, color: const Color(0xFF424242)),
                ),
                subtitle: UIDropdownButton<Map>(
                  hintText: 'Seleccione...',
                  items: entidades,
                  value: entityId.value == null ? null : entidades.where((e) => e['id'] == entityId.value).firstOrNull,
                  itemBuilder: (item) => item['name'],
                  onChanged: (value) {
                    entityId.value = value?['id']!;
                  },
                ),
              );
            }
          ),
        
        ],
      ),
    );
  }
}

/// STEP 2
class Step2 extends StatelessWidget {
  
  final TextEditingController emailC;
  final TextEditingController passwordC;
  final TextEditingController repeatPasswordC;

  const Step2({
    super.key,
    required this.emailC,
    required this.passwordC,
    required this.repeatPasswordC,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 10,
        children: [

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Seguridad',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 10),

          UITextFormField(
            title: 'Correo',
            hintText: 'Ej: example@google.com',
            borderRadius: 15,
            validateEmail: true,
            focusBorder: Colors.grey.shade400,
            controller: emailC,
          ),
  
          UITextFormField(
            title: 'Contraseña',
            hintText: '*******',
            borderRadius: 15,
            focusBorder: Colors.grey.shade400,
            isPassword: true,
            controller: passwordC,
            validEqualsText: repeatPasswordC,
          ),
  
          UITextFormField(
            title: 'Confirmar contraseña',
            hintText: '*******',
            borderRadius: 15,
            focusBorder: Colors.grey.shade400,
            isPassword: true,
            controller:  repeatPasswordC,
            validEqualsText: passwordC,
          ),
        ],
      ),
    );
  }
}

/// STEP 3
class Step3 extends StatelessWidget {
  const Step3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.check_circle,
              size: 90,
              color: Colors.green.shade600,
            ),

            const SizedBox(height: 20),

            const Text(
              '¡Todo listo!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Tu cuenta ha sido creada correctamente.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}