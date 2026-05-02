import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UIText extends StatelessWidget {
  final String? title;
  final List? textRich;
  final Color? color;
  final double? size;
  final bool bold;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final bool centerText;
  final bool isRequired;
  final bool underline;
  final double height;
  final Function()? onTap;

  const UIText({
    super.key,
    this.title,
    this.bold = false,
    this.size,
    this.textRich,
    this.color = Colors.black, 
    this.overflow,
    this.letterSpacing,
    this.centerText = false,
    this.isRequired = false,
    this.underline = false,
    this.onTap,
    this.height = 1.1
  });

  @override
  Widget build(BuildContext context) {
    return 
      textRich == null?
      Text.rich(
        TextSpan(
          children: [

            if(isRequired)
              TextSpan(
                text: '* ',
                style: TextStyle(
                  color: Colors.red,
                ), 
              ),

            TextSpan(
              text: title ?? '',
              // recognizer: TapGestureRecognizer()
              // ..onTap = onTap
            ),

          ],
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            letterSpacing: letterSpacing,
            overflow: overflow,
            decorationColor: color,
            decoration: underline? TextDecoration.underline : null,
            height: height,
          ), 
        ),
        textAlign: centerText ? TextAlign.center : TextAlign.start,
      )
      :
       Text.rich(
        TextSpan(
          children: textRich!.map((text) 
            => TextSpan(
              text: '${text['text']} ',
              style: TextStyle(
                color: text['color'],
                fontSize: text['size'],
                fontWeight: text['bold'] != null && text['bold']? FontWeight.bold : FontWeight.normal,
                height: height,
              ),
              recognizer: text['onTap'] != null? _onTap(text) : null
            )
          ).toList(),
        )
       );
  }

  GestureRecognizer? _onTap(Map text) {
    return TapGestureRecognizer()
    ..onTap = () {
      if(text['onTap'] != null){
        text['onTap']();
      }
    };
  }
}

