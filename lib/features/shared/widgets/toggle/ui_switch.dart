import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UISwitch extends ConsumerWidget {
  
  final bool active;
  final Color activeTrackColor;
  final Color activeThumbColor;
  final Color inactiveTrackColor;
  final Color inactiveThumbColor;
  final double scale;
  final Function(bool)? onChanged;

  const UISwitch({
    super.key,
    this.active = false,
    this.activeTrackColor = Colors.blueGrey,
    this.activeThumbColor = Colors.white,
    this.inactiveTrackColor = Colors.grey,
    this.inactiveThumbColor = Colors.white,
    this.scale = 0.8,
    this.onChanged
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Transform.scale(
      scale: scale,
      child: Switch(
        activeTrackColor: activeTrackColor,
        activeThumbColor: activeThumbColor,
        trackOutlineColor: WidgetStatePropertyAll(Colors.black12),
        padding: EdgeInsets.zero,
        inactiveTrackColor: inactiveTrackColor,
        inactiveThumbColor: inactiveThumbColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: active,
        onChanged: onChanged,
      ),
    );
  }
}