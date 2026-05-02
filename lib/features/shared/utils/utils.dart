import 'package:flutter/material.dart';


class UnFocusKeyboard extends StatelessWidget {
  
  final Widget child;

  const UnFocusKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}