
import 'package:civigo/config/route_config/route_paths.dart';
import 'package:civigo/features/reports/presentation/widgets/report_botton.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportPage extends StatelessWidget {
  
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.shield_outlined, color: Color(0xFF0A214D),),

                const SizedBox(width: 10,),

                const Text("CiviGo", style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0A214D)),),
              ],
            ),

           const Icon(Icons.person, color : Color(0xFF0A214D))
          ],
        ),
      ),

      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
       child: SingleChildScrollView(
        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
              SizedBox(height: 30,),
          
              UIText(
                title: "New Incident Report", 
                bold: true, 
                color: const Color.fromARGB(255, 15, 18, 65),
                size: 40
              ),
          
              SizedBox(height: 10,),
          
              UIText(
               title: "New Incident Report Follow the steps below to log a localized issue. Our Al assists in categorizing and extracting details from media.",
               size: 15,
               color: Colors.grey,
              ),
          
              SizedBox(height: 35,),
          
              ReportBottom(
                backgroundColorButom: const Color.fromARGB(255, 18, 10, 88),
              insideColor: Colors.white,
              title: "crea un nuevo reporte invecil",
              sizeTitle: 15,
              onPressed: () => context.pushNamed(RoutePaths.reportSteps),

              ),

              SizedBox(height: 10,),

              ReportBottom(
              backgroundColorButom: Colors.white,
              insideColor: const Color.fromARGB(255, 18, 10, 88),
              title: "mira los reportes que has echo pedazo de caga",
              sizeTitle: 15,
              onPressed: () {
                  
                },
              )
              
          
          
            ],
          ),
        ),
       )
      ) 
    );
  }
}

