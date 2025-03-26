import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/tooltip_and_semantics.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/shrink_effect_wrapper.dart';

class RoundedFAButton extends StatelessWidget {
  const RoundedFAButton({
    required this.icon,
    required this.onTap,
    required this.identifier,
    required this.semanticHint,
    required this.toolTipOrSemantics,
    super.key,
  });

  final IconData icon;
  final String semanticHint;
  final WidgetIdentifier identifier;
  final ToolTipOrSemantics toolTipOrSemantics;
  final void Function(WidgetIdentifier tag) onTap;

  @override
  Widget build(BuildContext context) {
    return ShrinkEffectWrapper(
      tapDownScale: 0.9,
      sematicHint: semanticHint,
      tooltipOrSemantics: toolTipOrSemantics,
      child: FloatingActionButton(
        key: identifier.key,
        enableFeedback: true,
        heroTag: identifier.name,
        shape: const CircleBorder(),
        onPressed: () => onTap(identifier),
        tooltip: toolTipOrSemantics.toolTip,
        child: Icon(
          icon,
          color: context.theme.primaryColor,
        ),
      ),
    );
  }
}
