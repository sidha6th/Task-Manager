import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class IconButtonWithSemantics extends StatelessWidget {
  const IconButtonWithSemantics({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.semanticsLabel,
    this.sortKey,
    super.key,
  });

  final Widget icon;
  final VoidCallback onPressed;
  final String tooltip;
  final String? semanticsLabel;
  final SemanticsSortKey? sortKey;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      sortKey: sortKey,
      label: semanticsLabel ?? tooltip,
      tooltip: tooltip,
      child: ExcludeSemantics(
        child: IconButton(
          icon: icon,
          onPressed: onPressed,
          tooltip: tooltip,
        ),
      ),
    );
  }
}
