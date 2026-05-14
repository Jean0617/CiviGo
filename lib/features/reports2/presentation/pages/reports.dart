import 'package:civigo/features/reports2/presentation/widgets/filters_reports.dart';
import 'package:civigo/features/shared/widgets/container/form_no_data.dart';
import 'package:civigo/features/shared/widgets/text/ui_title_action.dart';
import 'package:civigo/features/shared/widgets/textformfield/ui_text_form_field.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
   
  const ReportPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(padding: EdgeInsetsGeometry.only(left: 10, right: 10, top: 29),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UITitleAction(
              title: "REPORTES", 
              subTitle: "extrae reportes de las incidencias"),
          
            SizedBox(height: 5),

            Row(
             spacing: 5,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [

              Expanded(
               child: UITextFormField(
                hintText: 'Buscar por identificación o nombre...',
                borderRadius: 30,
                focusBorder: Colors.grey.shade400,
                suffixIcon: IconButton(
                 icon: Icon(Icons.search),
                 onPressed: (){}, 
                  ),
                ),
              ),

              IconButton(
               style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                 RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
                        )
                       ),
                padding: WidgetStatePropertyAll(EdgeInsets.all(13)),
                backgroundColor: WidgetStatePropertyAll(Colors.black.withAlpha(20))
                      ),
                tooltip: 'Filtros',
                icon: Icon(Icons.filter_alt_outlined, color: Colors.black54, size: 22,),
                onPressed: (){

                 showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, 
                  backgroundColor: Colors.transparent,
                  builder: (context) => const FiltersReports(),
                 );
                }
              ) 
           ],
          ),
         
         
            SizedBox(height: 20),
            
            FormNoData(),

         ]
        ),
       ),
      )
    );
  }
}

