import 'package:flutter/material.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class GenericErrorWidget extends StatelessWidget {
  const GenericErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TextWidget('Something went wrong'),
    );
  }
}
