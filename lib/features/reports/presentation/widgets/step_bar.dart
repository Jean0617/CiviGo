
import 'package:flutter/material.dart';

class StepBar extends StatelessWidget {
  final int currentStep; // Recibe 1, 2, 3...
  final int fullStep; // Recibe 3

  const StepBar({super.key, required this.currentStep, required this.fullStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Texto "Paso 1 de 3"
          Text('Paso $currentStep de $fullStep',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          ClipRRect( // Esto redondea las esquinas de la barra
            borderRadius: BorderRadius.circular(8),
            child: TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 300), // Mismo tiempo que el PageView
              // tween: de dónde a dónde va la animación
              // begin: 0 = barra vacía. end: calculamos el % de progreso
              tween: Tween(begin: 0, end: currentStep / fullStep),
              // builder se ejecuta en cada frame de la animación
              // value va de 0 a 0.33, luego a 0.66, luego a 1.0
              builder: (context, value, _) => LinearProgressIndicator(
                value: value, // LinearProgressIndicator usa 0.0 a 1.0 para el % de llenado
                minHeight: 8, // Grosor de la barra
                backgroundColor: Colors.grey[300], // Color de la parte "vacía"
              ),
            ),
          ),
        ],
      ),
    );
  }
}