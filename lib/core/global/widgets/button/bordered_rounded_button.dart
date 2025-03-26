import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/button/rounded_button_widget.dart';
import 'package:task_manager/core/global/widgets/decoration_box_widget.dart';

class BorderedRoundedButtonWidget extends StatelessWidget {
  const BorderedRoundedButtonWidget({
    required this.onTap,
    required this.label,
    this.icon,
    this.style,
    this.heroTag,
    this.iconColor,
    this.borderColor,
    this.borderRadius,
    this.isLoading = false,
    this.borderThickness = 4,
    this.contentPadding = const EdgeInsets.all(12),
    super.key,
  });

  final String label;
  final IconData? icon;
  final bool isLoading;
  final Color? iconColor;
  final TextStyle? style;
  final VoidCallback onTap;
  final Color? borderColor;
  final double borderThickness;
  final WidgetIdentifier? heroTag;
  final EdgeInsets contentPadding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(30);
    return DecoratedBoxWidget(
      borderRadius: radius,
      color: borderColor ?? context.theme.colorScheme.inverseSurface,
      child: Padding(
        padding: EdgeInsets.all(borderThickness),
        child: CommonRoundedButton(
          icon: icon,
          onTap: onTap,
          label: label,
          style: style,
          heroTag: heroTag,
          borderRadius: radius,
          isLoading: isLoading,
          iconColor: iconColor,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
