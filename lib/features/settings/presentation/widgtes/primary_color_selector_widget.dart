import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/primary_colors.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/list_extension.dart';
import 'package:task_manager/features/settings/presentation/widgtes/primary_color_indicator_widgt.dart';

class PrimaryColorSelectorWidget extends StatefulWidget {
  const PrimaryColorSelectorWidget({
    required this.onChange,
    required this.selecteColorCode,
    super.key,
  });

  final int? selecteColorCode;
  final void Function(int colorCode) onChange;

  @override
  State<PrimaryColorSelectorWidget> createState() =>
      _PrimaryColorSelectorWidgetState();
}

class _PrimaryColorSelectorWidgetState
    extends State<PrimaryColorSelectorWidget> {
  late var selectedIndex = PrimaryColors.values.indexWhereWithWithFallbackIndex(
    (element) => element.colorCode == widget.selecteColorCode,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: List.generate(
          PrimaryColors.values.length,
          (index) {
            return PrimaryColorIndicatorWidget.withColorCode(
              selected: selectedIndex == index,
              onTap: () => _onSelectColor(index),
              heroTag: WidgetIdentifier.primaryColorIndicator,
              colorCode: PrimaryColors.values[index].colorCode,
              semanticLabel: PrimaryColors.values[index].semanticLable,
            );
          },
        ),
      ),
    );
  }

  void _onSelectColor(int index) {
    log(PrimaryColors.values[index].name);
    setState(() => selectedIndex = index);
    widget.onChange(PrimaryColors.values[index].colorCode);
  }
}
