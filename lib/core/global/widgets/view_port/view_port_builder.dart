import 'package:flutter/material.dart';
import 'package:task_manager/core/global/constants.dart';

class ViewPortBuilder extends StatelessWidget {
  const ViewPortBuilder({
    required this.tabView,
    required this.mobileView,
    this.minTabViewPortWidth = Constants.minTabViewPortWidth,
    super.key,
  });

  final Widget Function() mobileView;
  final Widget Function() tabView;
  final double minTabViewPortWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= minTabViewPortWidth) return tabView();

        return mobileView();
      },
    );
  }
}
