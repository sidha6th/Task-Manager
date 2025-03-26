import 'package:flutter/material.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class RegularAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const RegularAppBarWidget({
    required this.title,
    this.semanticLabel,
    this.titleHeroTag,
    this.action,
    super.key,
  });

  final String title;
  final String? semanticLabel;
  final List<Widget>? action;
  final String? titleHeroTag;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      excludeHeaderSemantics: true,
      title: TextWidget(
        title,
        autoFocus: true,
        heroTag: titleHeroTag,
        semanticsLabel: semanticLabel ?? title,
      ),
      actions: action,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
