
import 'package:flutter/material.dart';

import '../../../shared/widgets/buttons/ui_button.dart';

class AuthPage extends StatelessWidget {
  
  AuthPage({super.key});

  final ValueNotifier<bool> valueToggle = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
  
            UIButton(
              title: 'Iniciar Sesión',
              expand: true,
              bold: true,
              background: Colors.transparent,
              fontColor: Colors.black54,
            )
      
        ],
      ),
    ),
    );
  }
}
