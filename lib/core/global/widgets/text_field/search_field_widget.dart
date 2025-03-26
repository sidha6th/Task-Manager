import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/text_field/text_form_field_widget.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({
    required this.hint,
    this.onTap,
    this.border,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.prefixIcon,
    this.controller,
    this.initialValue,
    this.maxLines = 1,
    this.keyboardType,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    super.key,
  });

  final String hint;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final bool autofocus;
  final int? maxLength;
  final bool autocorrect;
  final bool obscureText;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final InputBorder? border;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha(25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormFieldWidget(
        onTap: onTap,
        enabled: enabled,
        readOnly: readOnly,
        maxLines: maxLines,
        autofocus: autofocus,
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        controller: controller,
        autocorrect: autocorrect,
        obscureText: obscureText,
        keyboardType: keyboardType,
        initialValue: initialValue,
        textInputAction: textInputAction,
        inputDecoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: context.theme.colorScheme.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          prefixIconConstraints:
              const BoxConstraints.expand(height: 25, width: 40),
          border: border ??
              OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50),
              ),
        ),
      ),
    );
  }
}
