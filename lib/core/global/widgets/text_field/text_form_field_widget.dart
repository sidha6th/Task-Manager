import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    this.labelText,
    this.border,
    this.validator,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
    this.initialValue,
    this.autocorrect = true,
    this.autofocus = false,
    this.maxLength,
    this.onTap,
    this.readOnly = false,
    this.textInputAction,
    this.onEditingComplete,
    super.key,
    this.prefix,
    this.inputDecoration,
    this.onFieldSubmitted,
    this.hintText,
  });

  final int? maxLines;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final void Function(String)? onChanged;
  final String? initialValue;
  final bool autocorrect;
  final bool autofocus;
  final int? maxLength;
  final VoidCallback? onTap;
  final InputBorder? border;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final Widget? prefix;
  final InputDecoration? inputDecoration;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      onChanged: onChanged,
      initialValue: initialValue,
      autocorrect: autocorrect,
      autofocus: autofocus,
      maxLength: maxLength,
      onTap: onTap,
      readOnly: readOnly,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: inputDecoration ??
          InputDecoration(
            labelText: labelText,
            prefix: prefix,
            hintText: hintText,
            border: border ?? const OutlineInputBorder(),
          ),
    );
  }
}
