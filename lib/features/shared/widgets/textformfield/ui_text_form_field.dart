import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UITextFormField extends StatefulWidget {
  final String? title;
  final String? label;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final bool isPassword;
  final bool validateEmail;
  final bool validateNoSpaces;
  final bool validatePasswordStrength;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color? textColor;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final bool readOnly;
  final int? minLength;
  final bool? isNumeric;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final int? maxLines;
  final bool showBorder;
  final bool autoValidate;
  final bool showErrorStyle;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final double? borderRadius;
  final double fontSize;
  final bool isFilled;
  final Color titleColor;
  final bool boldTitle;
  final Color focusBorder;

  const UITextFormField({
    super.key,
    this.title,
    this.label,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.validateEmail = false,
    this.validateNoSpaces = false,
    this.validatePasswordStrength = false,
    this.prefixIcon,
    this.fillColor,
    this.textColor,
    this.contentPadding,
    this.suffixIcon,
    this.readOnly = false,
    this.minLength,
    this.isNumeric,
    this.onChanged,
    this.onTap,
    this.maxLines,
    this.showBorder = true,
    this.autoValidate = true,
    this.showErrorStyle = true,
    this.onFieldSubmitted,
    this.focusNode,
    this.borderRadius,
    this.isFilled = true,
    this.initialValue,
    this.fontSize = 14.0,
    this.titleColor = const Color(0xFF424242),
    this.boldTitle = true,
    this.focusBorder = Colors.black
  });

  @override
  State<UITextFormField> createState() => _UITextFormFieldState();
}

class _UITextFormFieldState extends State<UITextFormField> {
  late final ValueNotifier<bool> _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = ValueNotifier(!widget.isPassword);
  }

  @override
  void dispose() {
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isPasswordVisible,
      builder: (context, isVisible, child) {
        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          visualDensity: VisualDensity.compact,
          title: _buildTitle(),
          subtitle: _buildTextFormField(isVisible),
        );
      },
    );
  }

  Widget _buildTitle() {
    if (widget.title == null) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        widget.title!,
        style: TextStyle(
          fontSize: 13,
          color: widget.titleColor,
          fontWeight: widget.boldTitle ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTextFormField(bool isPasswordVisible) {
    return TextFormField(
      key: ValueKey(widget.controller?.hashCode ?? widget.initialValue),
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      cursorColor: widget.textColor ?? Colors.black,
      style: TextStyle(color: widget.textColor, fontSize: widget.fontSize),
      maxLines: widget.isPassword ? 1 : widget.maxLines ?? 1,
      readOnly: widget.readOnly,
      obscureText: widget.isPassword && !isPasswordVisible,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      autovalidateMode: widget.autoValidate 
          ? AutovalidateMode.onUserInteraction 
          : AutovalidateMode.disabled,
      inputFormatters: _buildInputFormatters(),
      decoration: _buildInputDecoration(isPasswordVisible),
      validator: widget.autoValidate ? _validator : null,
    );
  }

  List<TextInputFormatter>? _buildInputFormatters() {
    if (widget.isNumeric != true) return null;
    
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,4}')),
    ];
  }

  InputDecoration _buildInputDecoration(bool isPasswordVisible) {
    final borderRadius = BorderRadius.circular(widget.borderRadius ?? 10);
    final borderSide = widget.showBorder 
        ? const BorderSide(color: Color(0xFFDEDEDE), width: 1)
        : BorderSide.none;

    return InputDecoration(
      contentPadding: widget.contentPadding ?? 
          EdgeInsets.symmetric(horizontal: 12, vertical: widget.maxLines != null ? 12 : 8),
      hintText: widget.hintText,
      hintStyle: TextStyle(
        color: const Color(0xFF8B8B8B),
        fontSize: widget.fontSize,
      ),
      label: widget.label != null 
          ? Text(widget.label!, style: const TextStyle(fontSize: 16))
          : null,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _buildSuffixIcon(isPasswordVisible),
      fillColor: widget.fillColor ?? Colors.white,
      filled: widget.isFilled,
      errorStyle: widget.showErrorStyle 
          ? const TextStyle(color: Colors.red, fontSize: 12)
          : const TextStyle(fontSize: 0, height: 0),
      
      // Bordes optimizados
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: widget.focusBorder, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    );
  }

  Widget? _buildSuffixIcon(bool isPasswordVisible) {
    if (widget.isPassword) {
      return IconButton(
        onPressed: _togglePasswordVisibility,
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: isPasswordVisible ? Colors.grey : Colors.blueGrey,
        ),
        tooltip: 'Toggle password visibility',
      );
    }
    return widget.suffixIcon;
  }

  void _togglePasswordVisibility() {
    if (widget.isPassword) {
      _isPasswordVisible.value = !_isPasswordVisible.value;
    }
  }

  String? _validator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Campo requerido';
    }

    final text = value!;
    
    // Validaciones específicas
    if (widget.validateEmail && !EmailValidator.validate(text)) {
      return 'Correo inválido';
    }
    
    if (widget.validateNoSpaces && text.contains(' ')) {
      return 'No puede contener espacios';
    }
    
    if (widget.minLength != null && text.length < widget.minLength!) {
      return 'Mínimo ${widget.minLength} caracteres';
    }

    if (widget.validatePasswordStrength && !_isStrongPassword(text)) {
      return _getPasswordError(text);
    }

    return null;
  }

  bool _isStrongPassword(String password) {
    return password.length >= 8 &&
           RegExp(r'[0-9]').hasMatch(password) &&
           RegExp(r'[A-Z]').hasMatch(password) &&
           RegExp(r'[a-z]').hasMatch(password) &&
           RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  String _getPasswordError(String password) {
    if (password.length < 8) return 'Mínimo 8 caracteres';
    if (!RegExp(r'[0-9]').hasMatch(password)) return 'Requiere número';
    if (!RegExp(r'[A-Z]').hasMatch(password)) return 'Requiere mayúscula';
    if (!RegExp(r'[a-z]').hasMatch(password)) return 'Requiere minúscula';
    return 'Requiere carácter especial';
  }
}