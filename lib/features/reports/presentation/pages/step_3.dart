
import 'package:flutter/material.dart';

class Step3 extends StatelessWidget {
   
  const Step3({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                  'Tu reporte se ha creado correctamente.',
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        )
      )
      
    );
  }
}