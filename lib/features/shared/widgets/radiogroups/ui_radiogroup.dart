import 'package:flutter/material.dart';

class UIRadioGroup<T> extends StatelessWidget {

  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String Function(T item) labelBuilder;
  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;
  final EdgeInsetsGeometry itemPadding;
  final bool enabled;

  const UIRadioGroup({
    super.key,
    required this.items,
    required this.value,
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

    return RadioGroup<T>(
      groupValue: value,
      onChanged: enabled
          ? onChanged
          : (_) {},
      child: direction == Axis.horizontal
          ? Wrap(
              alignment: alignment,
              spacing: spacing,
              runSpacing: runSpacing,
              children: items.map(_buildItem).toList(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map(_buildItem).toList(),
            ),
    );
  }

  Widget _buildItem(T item) {

    final isSelected = item == value;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: enabled
          ? () => onChanged(item)
          : null,
      child: Padding(
        padding: itemPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Radio<T>(
              value: item,
              activeColor: Colors.blueGrey,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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