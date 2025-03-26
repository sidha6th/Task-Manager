import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final tween = Tween<double>(begin: 1, end: 0.5);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: tween,
      duration: const Duration(milliseconds: 500),
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
