import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class Step2 extends StatelessWidget {
   
  const Step2({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 35, top: 10, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              

              SizedBox(height: 20,),
          
              UIText(
                title: "seleciona una imagen para analizarla con ia", 
                size: 30,
                bold: true,
                color: Color(0xFF0A214D),
                ),
              
                
              SizedBox(height: 20,),
              
              CardMediaEvidence(),
          
              Spacer(),
                
              ButtonNextStep()
            ],
          ),
        )
      )
      
    );
  }
}

