import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  
  AuthPage({super.key});

  final ValueNotifier<bool> valueToggle = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Text('Login')
      ),
    );
  }
}