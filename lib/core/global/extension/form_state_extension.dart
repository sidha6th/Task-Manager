import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension FormStateExtension on FormState {
  bool isNotValidated() {
    if (validate()) return false;

    HapticFeedback.mediumImpact();
    return true;
  }
}
