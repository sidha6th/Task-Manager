import 'package:flutter/material.dart';

extension BuildContextNavigationExtension on BuildContext {
  Future<T?> pushTo<T extends Object?>(Widget page) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget page, [
    TO? result,
  ]) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => page),
      result: result,
    );
  }

  void pop<T extends Object?>([T? result]) {
    return Navigator.pop(this, result);
  }
}
