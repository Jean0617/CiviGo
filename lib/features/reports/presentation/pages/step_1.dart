import 'package:flutter/material.dart';
import '../../../shared/widgets/text/ui_text.dart';
import '../widgets/widgets.dart';

class Step1 extends StatelessWidget {
   
  const Step1({super.key});
  
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
                title: "Comenzemos eligiendo una clasificacion para tu reporte", 
                size: 30,
                bold: true,
                color: Color(0xFF0A214D),
                ),
              
                
              SizedBox(height: 20,),
              
              CardClasificationWidget(),
          
              Spacer(),
                
              ButtonNextStep()
            ],
          ),
        )
      )
      
    );
  }
}

      