import 'package:civigo/features/shared/widgets/text/ui_text.dart';
import 'package:flutter/material.dart';

class UIButton extends StatelessWidget {

  final String title;
  final bool expand;
  final Color background;
  final Color colorIcon;
  final Color fontColor;
  final double fontSize;
  final double iconSize;
  final bool bold;
  final BorderSide? border;
  final double borderRadius;
  final double elevation;
  final EdgeInsets padding;
  final Widget? icon;
  final bool iconAlignmentStart;
  final List<dynamic>? textRich;
  final Function()? onPressed;

  const UIButton({
    super.key,
    this.title = '',
    this.expand = false,
    this.background = Colors.white,
    this.colorIcon = Colors.black,
    this.fontColor = Colors.black,
    this.fontSize = 15,
    this.iconSize = 20,
    this.bold = false,
    this.border,
    this.borderRadius = 30,
    this.elevation = 0,
    this.padding = const EdgeInsets.symmetric(vertical: 15),
    this.onPressed,
    this.icon,
    this.iconAlignmentStart = true,
    this.textRich
  });

  @override
  Widget build(BuildContext context) {

    // Si se quiere expandir el boton 
    return expand?
      Row(
        children: [
          Expanded(
            child: buildButton()
          )
        ],
      )
    : buildButton();
  }

  ElevatedButton buildButton() {
    return ElevatedButton.icon(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(padding),
        elevation: WidgetStatePropertyAll(elevation),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: border ?? BorderSide.none,
            borderRadius: BorderRadiusGeometry.circular(borderRadius)
          )
        ),
        backgroundColor: WidgetStatePropertyAll(background)
      ),
      iconAlignment: iconAlignmentStart? IconAlignment.start : IconAlignment.end,
      icon: icon,
      label: UIText(
        textRich: textRich,
        title: title,
        bold: bold,
        color: fontColor,
        size: fontSize,
      ),
      onPressed: onPressed, 
    );
  }
}