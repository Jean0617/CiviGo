import 'package:civigo/config/app_config/app_config.dart';
import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';

class FormNoData extends StatelessWidget {
  
  final String title;
  final String subTitle;
  final Color color;

  const FormNoData({
    super.key,
    this.title = 'Sin información',
    this.subTitle = 'No hay registros disponibles para mostrar.',
    this.color = AppConfig.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppConfig.primaryColor.withAlpha(30),
        border: Border.all(color: AppConfig.primaryColor.withAlpha(50)),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        spacing: 5,
        children: [

          Icon(Icons.info_outline, color: color.withAlpha(200), size: 25,),
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              UIText(
                title: title,
                color: color,
                size: 16,
                bold: true,
              ),
      
              UIText(
                title: subTitle,
                color: color
              ),
              
            ],
          ),
      
        ],
      ),
    );
  }
}