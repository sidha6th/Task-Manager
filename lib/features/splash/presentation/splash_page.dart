import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_navigation_extension.dart';
import 'package:task_manager/features/dashboard/dashboard.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({required this.isSetupDone, super.key});

  final bool isSetupDone;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      onEnd: () {
        if (!isSetupDone) return;
        context.pushReplacement(const Dashboard());
      },
      tween: Tween<double>(begin: 1, end: 0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.slowMiddle,
      builder: (context, value, child) {
        return Center(
          child: Opacity(
            opacity: value,
            child: FlutterLogo(
              size: context.width * 0.3,
            ),
          ),
        );
      },
    );
  }
}
