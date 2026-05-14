import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetStateReport extends ConsumerWidget{
  const GetStateReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      
          Row(
            children: [
              const Icon(Icons.list_alt_sharp, size: 18,),
              const SizedBox(width: 10),
              UIText(title: "estado de el incidente", size: 18, bold: true),
            ],
          ),
      
          SizedBox(height: 12,),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
      
              SizedBox(width: 28,),
      
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                 decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 255, 255, 255), 
                 border: Border.all(color:Colors.grey.shade400),
                 borderRadius: BorderRadius.circular(5),
                 ),
                 child: UIText(title: "reportado", size: 12,)
               ),
      
               SizedBox(width: 10,),
      
               
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                 decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 255, 255, 255), 
                 border: Border.all(color: Colors.grey.shade400),
                 borderRadius: BorderRadius.circular(5),
                 ),
                 child: UIText(title: "en revision", size: 12,)
               ),
            ],
          ),
      
          SizedBox(height: 15,),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
      
              SizedBox(width: 28,),
      
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                 decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 255, 255, 255), 
                 border: Border.all(color:Colors.grey.shade400),
                 borderRadius: BorderRadius.circular(5),
                 ),
                 child: UIText(title: "en progreso", size: 12,)
               ),
      
               SizedBox(width: 10,),
      
               
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                 decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 255, 255, 255), 
                 border: Border.all(color: Colors.grey.shade400),
                 borderRadius: BorderRadius.circular(5),
                 ),
                 child: UIText(title: "resuelto", size: 12,)
               ),
            ],
          )
        ]
      ),
    );
  }
}