import 'package:civigo/config/app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../shared/widgets/buttons/ui_button.dart';
import '../providers/providers.dart';

class ButtonNextStep extends ConsumerWidget {
  const ButtonNextStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(reporteProvider.notifier);

    return Padding(
      padding: EdgeInsets.all(16),
      child: UIButton(
        title: "siguiente",
        expand: true,
        padding: EdgeInsets.symmetric(vertical: 20),
        background: AppConfig.primaryColor,
        bold: true,
        fontSize: 18,
        fontColor: Colors.white,
        onPressed: () {
          notifier.nextStep();
        },
      ),
    );
  }
}