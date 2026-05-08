
import 'package:civigo/features/reports2/presentation/widgets/date_range.dart';
import 'package:civigo/features/reports2/presentation/widgets/get_category.dart';
import 'package:civigo/features/reports2/presentation/widgets/get_state_report.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';



class GenerateReport extends StatelessWidget {
  
  const GenerateReport({super.key});


  @override
  Widget build (BuildContext context,) {

    return Scaffold(
     body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20 ),
      children: [
        
        UIText(title: "reportes excel", size: 30, bold: true,),
        SizedBox(height: 10,),
        UIText(title: "configure los parametros para genererar una exportacion detallada de los incidentes registrados en el sistema municipal.", color: Colors.grey,),

        DateRange(),
         
        GetCategory(),

        GetStateReport()

      ],
     ),
    );
  }
}


