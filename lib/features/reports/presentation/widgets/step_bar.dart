
import 'package:civigo/config/app_config/app_config.dart';
import 'package:flutter/material.dart';

class StepBar extends StatelessWidget {
  final int currentStep; // Recibe 1, 2, 3...
  final int fullStep; // Recibe 3

  const StepBar({super.key, required this.currentStep, required this.fullStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = currentStep == index;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: 4),
            height: isActive? 6 : 6,
            width: isActive? 30 : 6,
            decoration: BoxDecoration(
              color: isActive
                  ? AppConfig.primaryColor.withAlpha(200)
                  : Colors.grey.shade400,
              borderRadius: BorderRadius.circular(20),
            ),
          );
        }),
      ),
    );
  }
}