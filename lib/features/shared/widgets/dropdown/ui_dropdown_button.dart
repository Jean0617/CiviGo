import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class UIDropdownButton<T> extends StatefulWidget {
  /// Lista de datos (List<Map<String, dynamic>> o List<T>)
  final List<T> items;
  
  /// Valor seleccionado actual
  final T? value;
  
  /// Callback cuando cambia la selección
  final ValueChanged<T?>? onChanged;
  
  /// Texto de hint cuando no hay selección
  final String? hintText;
  
  /// Configuración de keys para Map<String, dynamic>
  final DropdownKeysConfig? keysConfig;
  
  /// Función para mostrar texto del item (para objetos custom)
  final String Function(T)? itemBuilder;
  
  /// Función para obtener valor del item (para objetos custom)
  final T Function(T)? valueBuilder;
  
  /// Altura máxima del dropdown
  final double? maxDropdownHeight;
  
  /// Radio de borde
  final double borderRadius;
  
  /// Color de fondo
  final Color? fillColor;
  
  /// Habilitado/deshabilitado
  final bool isEnabled;
  
  /// Validación automática
  final bool autoValidate;
  
  /// Padding interno
  final EdgeInsetsGeometry? contentPadding;
  
  /// Icono custom del dropdown
  final Widget? dropdownIcon;

  const UIDropdownButton({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
    this.keysConfig,
    this.itemBuilder,
    this.valueBuilder,
    this.maxDropdownHeight = 200,
    this.borderRadius = 10,
    this.fillColor,
    this.isEnabled = true,
    this.autoValidate = true,
    this.contentPadding,
    this.dropdownIcon,
  });

  @override
  State<UIDropdownButton<T>> createState() => _UIDropdownButtonState<T>();
}

class _UIDropdownButtonState<T> extends State<UIDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      key: ValueKey(widget.value?.hashCode ?? widget.items.length),
      
      // Validación optimizada
      autovalidateMode: widget.autoValidate 
          ? AutovalidateMode.onUserInteraction 
          : AutovalidateMode.disabled,
      validator: _validator,
      
      // Layout optimizado
      // isDense: true,
      isExpanded: true,
      alignment: AlignmentDirectional.centerStart,
      
      value: widget.value,
      decoration: _buildInputDecoration(),
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14
      ),
      
      hint: _buildHint(),
      
      items: _buildMenuItems(),
      
      onChanged: widget.isEnabled ? widget.onChanged : null,

      selectedItemBuilder: (context) {
        return widget.items.map((item) {
          final displayText = _getDisplayText(item);

          return Align(
            alignment: Alignment.centerLeft,
            child: Text(
              displayText,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList();
      },
      
      // Dropdown Style (v2.5+ optimizado)
      dropdownStyleData: DropdownStyleData(
        maxHeight: widget.maxDropdownHeight,
        width: null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        offset: const Offset(0, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(8),
          thickness: WidgetStatePropertyAll(4),
        ),
      ),
      
      // Button Style optimizado
      buttonStyleData: ButtonStyleData(
        padding: widget.contentPadding ?? 
            const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
        height: 47,
        width: double.infinity,
      ),
      
      // Icon Style mejorado
      iconStyleData: IconStyleData(
        icon: widget.dropdownIcon ?? 
            const Icon(Icons.arrow_drop_down_rounded, size: 20),
        iconSize: 20,
        iconEnabledColor: Colors.black54,
        iconDisabledColor: Colors.grey,
      ),
      
      // Menu Item Style
      menuItemStyleData: MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.zero,
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    final radius = BorderRadius.circular(widget.borderRadius);
    final enabledBorder = OutlineInputBorder(
      borderRadius: radius,
      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
    );

    return InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.zero,
      filled: true,
      fillColor: widget.fillColor ?? Colors.white,
      hintStyle: const TextStyle(
        color: Color(0xFF8B8B8B),
        fontSize: 14,
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 12,
        height: 1.2,
      ),
      border: enabledBorder,
      enabledBorder: enabledBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      alignLabelWithHint: true,
    );
  }

  Widget? _buildHint() {
    if (widget.value != null || widget.hintText == null) return null;
    
    return Text(
      widget.hintText!,
      style: const TextStyle(
        color: Color(0xFF8B8B8B),
        fontSize: 14,
      ),
    );
  }

  List<DropdownMenuItem<T>>? _buildMenuItems() {
    if (widget.items.isEmpty) {
      return [
        DropdownMenuItem<T>(
          enabled: false,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Text(
              'No hay datos disponibles',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ];
    }

    return widget.items.map((item) {
      final displayText = _getDisplayText(item);
      final itemValue = _getItemValue(item);
      
      return DropdownMenuItem<T>(
        key: ValueKey(itemValue?.hashCode ?? item.hashCode),
        value: itemValue ?? item,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Text(
            displayText,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }).toList();
  }

  String _getDisplayText(T item) {
    // Custom builder
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(item);
    }
    
    // Map keys config
    if (widget.keysConfig != null && item is Map<String, dynamic>) {
      return item[widget.keysConfig!.labelKey] ?? '';
    }
    
    // Default toString()
    return item.toString();
  }

  T? _getItemValue(T item) {
    if (widget.valueBuilder != null) {
      return widget.valueBuilder!(item);
    }
    
    if (widget.keysConfig != null && item is Map<String, dynamic>) {
      return item[widget.keysConfig!.valueKey] as T?;
    }
    
    return item;
  }

  String? _validator(T? value) {
    if (value == null || (value is Map && value['id'] != null && (value['id'] is num && value['id'] == -1))) {
      return 'Campo requerido';
    }
    return null;
  }
}

/// Configuración de keys para datos tipo Map
class DropdownKeysConfig {
  final String valueKey;
  final String labelKey;
  
  const DropdownKeysConfig({
    required this.valueKey,
    required this.labelKey,
  });
}