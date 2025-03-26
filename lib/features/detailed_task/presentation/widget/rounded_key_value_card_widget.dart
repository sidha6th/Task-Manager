import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/decoration_box_widget.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class RoundedKeyValueCardWidget extends StatelessWidget {
  const RoundedKeyValueCardWidget(
    this._key, {
    required this.value,
    this.icon,
    super.key,
  });

  final String _key;
  final String value;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBoxWidget(
      borderRadius: BorderRadius.circular(20),
      color: context.theme.focusColor.withAlpha(25),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextWidget(
                _key,
                style: context.theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color:
                      context.theme.textTheme.labelLarge?.color?.withAlpha(170),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 5,
                children: [
                  if (icon != null) icon!,
                  Flexible(
                    child: TextWidget(value,
                        style: context.theme.textTheme.labelLarge),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
