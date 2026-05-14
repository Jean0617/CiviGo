import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/shared/widgets/dropdown/ui_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/buttons/ui_button.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../../../shared/widgets/textformfield/ui_text_form_field.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _RegisterStepperPageState();
}

class _RegisterStepperPageState extends State<NewUserPage> {
  final PageController _pageController = PageController();

  int currentStep = 0;

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
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Step1(),
                Step2(),
                Step3(),
              ],
            ),
          ),

          /// BOTONES
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [

                /// ATRAS
                if (currentStep > 0 && currentStep != 2)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: previousStep,
                      child: const Text('Atrás'),
                    ),
                  ),

                if (currentStep > 0)
                  const SizedBox(width: 10),

                /// SIGUIENTE
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentStep == 2) {
                        debugPrint('Formulario completado');
                        return;
                      }

                      nextStep();
                    },
                    child: Text(
                      currentStep == 2
                          ? 'Finalizar'
                          : 'Siguiente',
                    ),
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

  final tipos = [
    {'id': 'CC', 'name': 'Cedula de ciudadania'},
    {'id': 'TI', 'name': 'Tarjeta de identidad'},
  ];

  Step1({super.key});

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

          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: UIText(title: 'Tipo identificación', bold: true, size: 13, color: const Color(0xFF424242)),
            ),
            subtitle: UIDropdownButton<Map>(
              hintText: 'Seleccione...',
              items: tipos,
              value: tipos[0],
              itemBuilder: (item) => item['name'] ?? '',
              onChanged: (value) {},
            ),
          ),
        
          UITextFormField(
            title: 'Numero identificación',
            hintText: 'Ej: 12345...',
            borderRadius: 10,
            focusBorder: Colors.grey.shade400,
          ),
        
          UITextFormField(
            title: 'Nombre completo',
            hintText: 'Ej: Juan andres perez...',
            borderRadius: 15,
            focusBorder: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}

/// STEP 2
class Step2 extends StatelessWidget {
  const Step2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
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

          const SizedBox(height: 20),

          UITextFormField(
            title: 'Correo',
            hintText: 'Ej: example@google.com',
            borderRadius: 15,
            validateEmail: true,
            focusBorder: Colors.grey.shade400,
          ),
  
          UITextFormField(
            title: 'Contraseña',
            hintText: '*******',
            borderRadius: 15,
            focusBorder: Colors.grey.shade400,
            isPassword: true,
          ),
  
          UITextFormField(
            title: 'Confirmar contraseña',
            hintText: '*******',
            borderRadius: 15,
            focusBorder: Colors.grey.shade400,
            isPassword: true,
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