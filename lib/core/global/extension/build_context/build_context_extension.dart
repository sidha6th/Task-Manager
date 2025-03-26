import 'package:flutter/material.dart';
import 'package:task_manager/core/global/constants.dart';

extension BuildContextExtension on BuildContext {
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  TextScaler get textScaler => MediaQuery.textScalerOf(this);
  Size get windowSize => MediaQuery.sizeOf(this);
  double get height => windowSize.height;
  double get width => windowSize.width;
  ThemeData get theme => Theme.of(this);

  ScaffoldMessengerState scaffoldMessenger() {
    return ScaffoldMessenger.of(this);
  }

  T? when<T>({
    required T Function() onMobileView,
    T Function()? orElse,
  }) {
    if (width < Constants.minTabViewPortWidth) {
      return onMobileView();
    }
    return orElse?.call();
  }
}
