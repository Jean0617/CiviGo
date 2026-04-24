import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UIText extends StatelessWidget {
  final String? title;
  final List? textRich;
  final Color? color;
  final double? size;
  final bool bold;
  final bool centerText;
  final bool required;
  final TextOverflow? overflow;


  const UIText({
    super.key,
    this.title,
    this.bold = false,
    this.size,
    this.overflow,
    this.textRich,
    this.centerText = false,
    this.color = Colors.black,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return 
      textRich == null?
        Text.rich(
          TextSpan(
            children: [

              if(required)
                TextSpan(
                  text: '* ',
                  style: TextStyle(
                    color: Colors.red.shade400,
                    fontSize: size,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  ),
                ),

              TextSpan(
                text: title ?? '',
                style: TextStyle(
                  color: color,
                  fontSize: size,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                ),
              )
            ]
          ),
          overflow: overflow,
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
                fontWeight: text['bold'] != null && text['bold']? FontWeight.bold : FontWeight.normal
              ),
              recognizer: TapGestureRecognizer()
              ..onTap = () {
                if(text['onTap'] != null){
                  text['onTap']();
                }
              },
            )
          ).toList(),
        )
       );
  }
}