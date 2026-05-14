import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/buttons/ui_button.dart';
import '../providers/step1_provider.dart';
import '../widgets/step1/cards_animated.dart';
import '../widgets/step1/step1_header.dart';

import 'package:civigo/config/app_config/app_config.dart';

class Step1 extends ConsumerStatefulWidget {
   
  const Step1({super.key});

  @override
  Step1State createState() => Step1State();
}

class Step1State extends ConsumerState<Step1> {

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Future.delayed(
        const Duration(milliseconds: 200),
        () => ref.read(step1Provider.notifier).setAnimate(true)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final stepState = ref.watch(step1Provider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 35, top: 10, left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
            
                CardsAnimated(animate: stepState.animate),
            
                Step1Header(),
            
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: UIButton(
                    background: AppConfig.primaryColor,
                    title: 'Abrir camara',
                    fontColor: Colors.white,
                    iconAlignmentStart: false,
                    bold: true,
                    isLoading: stepState.isOpeningCamera,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    fontSize: 16,
                    icon: Icons.camera_alt_outlined, 
                    onPressed: () async {
                      ref.read(step1Provider.notifier).takePhotoFlow(context, ref);
                    }
                  ),
                ),
            
              ],
            ),
          ),
        )
      )
    );
  }
}

