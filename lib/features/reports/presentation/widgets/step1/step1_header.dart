import 'package:flutter/material.dart';

import '../../../../shared/widgets/text/ui_text.dart';

class Step1Header extends StatelessWidget {

  const Step1Header({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
      
          UIText(
            title: "COMENCEMOS REGISTRANDO LA INCIDENCIA",
            size: 25,
            bold: true,
            centerText: true,
          ),
      
          SizedBox(height: 10),
      
          UIText(
            title: "Toma una foto del problema. Nuestra IA lo identificará automáticamente.",
            size: 17,
            centerText: true,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}