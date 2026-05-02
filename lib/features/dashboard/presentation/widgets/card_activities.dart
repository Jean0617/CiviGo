import 'package:flutter/material.dart';

import '../../../shared/widgets/text/ui_text.dart';

class CardActivities extends StatelessWidget {
  final String title;
  final int amount;
  final int inProgress;
  final int pending;

  const CardActivities({
    super.key,
    required this.title,
    this.amount = 0,
    this.inProgress = 0,
    this.pending = 0
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              UIText(
                title: title, color: Colors.black87, size: 15.0, bold: true,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withAlpha(20),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(Icons.report_gmailerrorred, color: Colors.blueGrey, size: 20,)
              ),

            ],
          ),
    
          UIText(
            title: '$amount', color: Colors.blueGrey, size: 35.0,
          ),
    
          const SizedBox(height: 5),
            
          Row(
            spacing: 10,
            children: [
    
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withAlpha(20),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      const Icon(Icons.circle, color: Colors.blue, size: 15,),
                      UIText(title: '$inProgress En progreso', color: Colors.black87, size: 11.0, bold: true),
                    ],
                  )
                ),
              ),
    
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withAlpha(20),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    spacing: 5,
                    children: [
                      const Icon(Icons.circle, color: Colors.grey, size: 15,),
                      UIText(title: '$pending Pendientes', color: Colors.black87, size: 11.0, bold: true),
                    ],
                  )
                ),
              ),
            ],
          ),
    
        ],
      ),
    );
  }
}