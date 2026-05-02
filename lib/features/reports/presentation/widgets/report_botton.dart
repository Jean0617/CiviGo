import 'package:flutter/material.dart';

class ReportBottom extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColorButom;
  final Color insideColor;
  final double sizeTitle;
  final Function()? onPressed;

  const ReportBottom({
    super.key, 
    this.title = "titulo", 
    this.subtitle = "subtitulo", 
    this.backgroundColorButom = const Color.fromARGB(255, 0, 0, 0),
    this.insideColor = Colors.white, 
    this.sizeTitle = 13.5, 
    this.onPressed, 
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColorButom,
        foregroundColor: insideColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(14)
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_box),

            SizedBox(width: 10,),
            
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                  style: TextStyle(
                   fontSize: sizeTitle
                   ),
                  ),

                  Text(subtitle,
                  style: TextStyle(
                  color: const Color.fromARGB(255, 187, 187, 187)
                  ),
                  ),
                ],
               ) 
              )
          ],
        ),
      ),
     );
  }
}