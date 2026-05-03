import 'package:flutter/material.dart';

class ActionButton<T> {
  final IconData icon;
  final Color? color;
  final String? tooltip;
  final void Function(T item) onPressed;

  ActionButton({
    required this.icon,
    required this.onPressed,
    this.color,
    this.tooltip,
  });
}