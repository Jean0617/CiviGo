import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetStateReport extends ConsumerWidget{
  const GetStateReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              const Icon(Icons.list_alt_sharp),
              const SizedBox(width: 10),
              UIText(title: "estado de el incidente", size: 20, bold: true),
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
                 border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                 borderRadius: BorderRadius.circular(5),
                 ),
                 child: UIText(title: "reportado", bold: true, size: 16,)
               ),

               SizedBox(width: 10,),

               
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                 decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 255, 255, 255), 
                 border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                 borderRadius: BorderRadius.circular(5),
                 ),
                 child: UIText(title: "en revision", bold: true, size: 16,)
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
                 border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                 borderRadius: BorderRadius.circular(5),
                 ),
                 child: UIText(title: "en progreso", bold: true, size: 16,)
               ),

               SizedBox(width: 10,),

               
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                 decoration: BoxDecoration(
                 color: const Color.fromARGB(255, 255, 255, 255), 
                 border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                 borderRadius: BorderRadius.circular(5),
                 ),
                 child: UIText(title: "en progreso", bold: true, size: 16,)
               ),
            ],
          )
        ]
      )
    );
  }
}