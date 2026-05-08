
import 'package:civigo/config/app_config/app_config.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/text/ui_text.dart';

class StepBar extends StatelessWidget {
  final int currentStep; // Recibe 1, 2, 3...
  final int fullStep; // Recibe 3

  const StepBar({super.key, required this.currentStep, required this.fullStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UIText(title: 'Paso ${currentStep+1} de $fullStep',bold: true, size: 16, color: Colors.black87,),
            ],
          ),
        ),
    
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Row(
            children: List.generate(3, (index) {
              final isActive = currentStep >= index;
    
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(right: 4),
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
    
      ],
    );
  }
}