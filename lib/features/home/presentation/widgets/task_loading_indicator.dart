import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/decoration_box_widget.dart';

class TaskLoadingIndicator extends StatelessWidget {
  const TaskLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final contentColor =
        context.theme.colorScheme.inverseSurface.withAlpha(150);

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return Card(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey,
                child: ListTile(
                  title: Row(
                    children: [
                      DecoratedBoxWidget(
                        color: contentColor,
                        child: SizedBox(
                          height: 8,
                          width: constraints.maxWidth * 0.8,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedBoxWidget(
                        color: contentColor,
                        child: const SizedBox(height: 10),
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          DecoratedBoxWidget(
                            color: contentColor,
                            child: const SizedBox(
                              height: 8,
                              width: 30,
                            ),
                          ),
                          DecoratedBoxWidget(
                            color: contentColor,
                            child: const SizedBox(
                              height: 8,
                              width: 40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
