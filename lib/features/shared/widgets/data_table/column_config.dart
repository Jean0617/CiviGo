import 'package:flutter/material.dart';

class ColumnConfig<T> {
  final String name;
  final String label;
  final double? width;
  final Widget Function(T item) builder;

  ColumnConfig({
    this.width,
    required this.name,
    required this.label,
    required this.builder,
  });
}