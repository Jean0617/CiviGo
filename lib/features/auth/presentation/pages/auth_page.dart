import 'package:flutter/material.dart';

import '../widgets/card_report.dart';

class AuthPage extends StatelessWidget {
  
  AuthPage({super.key});

  final ValueNotifier<bool> valueToggle = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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

                const Text("civic guard", style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0A214D)),),
              ],
            ),

           const Icon(Icons.person, color : Color(0xFF0A214D))
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              const SizedBox(height: 30,),

              const Text("Good morning, Alex.", 
               style: TextStyle(
                fontSize: 56, 
                fontWeight: FontWeight.w600, 
                color: Color(0xFF051838)
               ),
              ),
        
              const Text("stay informet and keep you comiunity safe, here is the lsated activity en you area", 
               style: TextStyle(
                fontSize: 16,
                color: Colors.grey
               ),
              ),
        
              const SizedBox(height: 20,),
        
              SizedBox(height: 55,width: 400,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF051838),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(14)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline_outlined),
                    SizedBox(width: 10,),
                    Text("Report Incident", style: TextStyle(
                      fontSize: 23
                    ),
                   ),
                  ],
                ),
               ),
              ),
        
              const SizedBox(height: 30,),
        
        
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    children: [
                      Icon(Icons.shield_outlined),
                      SizedBox(width: 10,),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Neighborhood Status:\nNormal", style: TextStyle(fontSize: 20),),
                          Text("no severe alerts in a 5-mile radius", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
        
              const SizedBox(height: 25,),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Recent Activity", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  Row(
                    children: [
                      Text("VIEW MAP ", style: TextStyle(fontSize: 15, color: const Color.fromARGB(255, 4, 82, 82), fontWeight: FontWeight.w500),),
                      Icon(Icons.arrow_forward, size: 18,)
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20,),
            
              CardReport(
               typeReport: 'traffic', 
               title: 'traffic light malfunction', 
               subtitle: 'mian  st & 4ht ave intersection signals are flashing red in all direccions proceed with...', 
               timePublication: '2th hago', 
               await: '0.5 mi away',
               colorIconReport: Colors.yellow
              ),

              CardReport(
               typeReport: 'utility', 
               title: 'Water Main Break', 
               subtitle: 'Flooding reported on the eastbound lane of Cedar Lane. City crews have been dispatched.', 
               timePublication: '1th ago', 
               await: '1.2 mi away',
               colorIconReport: Colors.blue,
                ),

              CardReport(
               typeReport: 'noise', 
               title: 'construccion noise', 
               subtitle: 'loud jack hammering reported outside of permitted hors near the new library', 
               timePublication: '3h ago', 
               await: '0.8 mi away',
               colorIconReport: Colors.blueGrey,
                ),   
            ],
          ),
        ),
      )
    );
  }
}

