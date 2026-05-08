import 'package:flutter/material.dart';

import '../../../../config/app_config/app_config.dart';
import 'ui_text.dart';

class UITitleAction extends StatelessWidget {
  
  final String title;
  final String subTitle;
  final String? tooltip;
  final IconData? icon;
  final EdgeInsets padding;
  final Function()? onTap;

  const UITitleAction({
    super.key,
    required this.title,
    required this.subTitle,
    this.tooltip,
    this.icon,
    this.padding = const EdgeInsets.only(left: 10),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      dense: true,
      minTileHeight: 0,
      contentPadding: padding,
      title: UIText( 
        title: title, color: Colors.black87, size: 25.0,
        bold: true,
      ),
      subtitle: UIText(title: subTitle, size: 12, color: Colors.black87,),
      trailing: icon != null?
        IconButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(10)
              )
            ),
            padding: WidgetStatePropertyAll(EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10)),
            alignment: Alignment.center,
            backgroundColor: WidgetStatePropertyAll(AppConfig.primaryColor)
          ),
          tooltip: tooltip,
          icon: Icon(icon, color: Colors.white, size: 20),
          onPressed: onTap
        )
      : null
    );
  }
}