import 'package:flutter/material.dart';

class CardReport extends StatelessWidget {
  final String typeReport;
  final String title;
  final String subtitle;
  final String timePublication;
  final String await;
  final Color colorIconReport;
  
  const CardReport({
    super.key, 
    required this.typeReport, 
    required this.title, 
    required this.subtitle, 
    required this.timePublication, 
    required this.await, 
    required this.colorIconReport,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(padding: EdgeInsetsGeometry.all(20),
         child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  margin: EdgeInsets.zero ,
                  color: const Color.fromARGB(158, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 6),
                    child: Row(
                      children: [
                        Icon(Icons.circle, size: 10, color: colorIconReport),
                        SizedBox(width: 5,),
                        Text(typeReport)
                      ]
                    ),
                  ),
                ),
      
                Text(timePublication, style: TextStyle(color: Colors.grey),)
              ],
            ),
      
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(title, style: TextStyle(fontSize: 20,),),
              subtitle: Text(subtitle,
              style: TextStyle(
                color: const Color.fromARGB(255, 88, 88, 88)
               ),
              ),
            ),
      
            Padding(
             padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
               color: Colors.grey[300],
               thickness: 1, 
              ),
            ),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(await),
                Icon(Icons.arrow_forward)
              ],
            )
          ],
         ),
        ),
      ),
    );
  }
}