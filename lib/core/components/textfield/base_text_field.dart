import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class BaseTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? padding;
  final void Function(String value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final bool readOnly;
  final bool? enabled;
  final bool? enableInteractiveSelection;
  final InputBorder? border;
  final InputDecoration? decoration;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final String? textAlign;
  final EdgeInsets? contentPadding;
  final int? maxLines;
  final int? maxLength;
  final Color? fillColor;
  final GestureTapCallback? onTap;
  final TextInputAction? textInputAction;

  const BaseTextField({
    super.key,
    this.controller,
    this.textInputAction,
    this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.border,
    this.maxLength,
    this.decoration,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.onTap,
    this.padding,
    this.onChanged,
    this.inputFormatters,
    this.textAlign,
    this.autofocus = false,
    this.readOnly = false,
    this.hint,
    this.enabled,
    this.enableInteractiveSelection,
    this.contentPadding,
    this.maxLines,
    this.fillColor,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: controller,
      obscureText: obscureText,
      maxLength: maxLength,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      validator: validator,
      autofocus: autofocus,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      focusNode: focusNode,
      onTap: onTap,
      keyboardType: keyboardType,
      enableInteractiveSelection: enableInteractiveSelection,
      onChanged: onChanged,
      textAlign: TextAlign.start,
      decoration: decoration ?? _buildDecoration(context),
      readOnly: readOnly,
      maxLines: maxLines,
    );
  }

  InputDecoration _buildDecoration(BuildContext context) => InputDecoration(
    contentPadding:
        contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    filled: true,
    border: const OutlineInputBorder(),
    counterText: "",
    labelText: label,
    hintText: hint,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
  );
}
