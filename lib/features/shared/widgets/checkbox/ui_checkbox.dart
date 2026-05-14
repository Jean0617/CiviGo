import 'package:flutter/material.dart';

class UICheckboxGroup<T> extends StatelessWidget {

  final List<T> items;
  /// Lista de seleccionados
  final List<T> values;
  /// Retorna la nueva lista seleccionada
  final ValueChanged<List<T>> onChanged;
  /// Texto a mostrar
  final String Function(T item) labelBuilder;
  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;
  final EdgeInsetsGeometry itemPadding;
  final bool enabled;

  const UICheckboxGroup({
    super.key,
    required this.items,
    required this.values,
    required this.onChanged,
    required this.labelBuilder,
    this.direction = Axis.vertical,
    this.alignment = WrapAlignment.start,
    this.spacing = 10,
    this.runSpacing = 5,
    this.itemPadding = const EdgeInsets.only(right: 10),
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {

    return direction == Axis.horizontal
    ? Wrap(
        alignment: alignment,
        spacing: spacing,
        runSpacing: runSpacing,
        children: items.map(_buildItem).toList(),
      )
    : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map(_buildItem).toList(),
      );
  }

  Widget _buildItem(T item) {

    final isSelected = values.contains(item);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: enabled
          ? () {
            final updatedValues = [...values];
            if (isSelected) {
              updatedValues.remove(item);
            } else {
              updatedValues.add(item);
            }
            onChanged(updatedValues);
          }
        : null,

      child: Padding(
        padding: itemPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Checkbox(
              side: BorderSide(),
              value: isSelected,
              activeColor: Colors.blueGrey,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: enabled
                  ? (_) {
                      final updatedValues = [...values];

                      if (isSelected) {
                        updatedValues.remove(item);
                      } else {
                        updatedValues.add(item);
                      }

                      onChanged(updatedValues);
                    }
                  : null,
            ),

            Flexible(
              child: Text(
                labelBuilder(item),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: enabled
                      ? Colors.black87
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}