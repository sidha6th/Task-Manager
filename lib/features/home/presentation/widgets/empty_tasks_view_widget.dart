import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_navigation_extension.dart';
import 'package:task_manager/core/global/extension/string_extension.dart';
import 'package:task_manager/core/global/widgets/button/bordered_rounded_button.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';
import 'package:task_manager/features/home/presentation/bloc/home_state.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/task_creation__or_updation_page.dart';

class EmptyTasksView extends StatelessWidget {
  const EmptyTasksView({
    required this.state,
    super.key,
  });

  final HomeState state;

  String get infoText {
    if (state.isFilterApplied) {
      return 'No tasks found';
    }
    return 'No tasks yet!';
  }

  IconData get infoIcon {
    if (state.filterSettings.searchQuery.hasData) return Icons.search;
    if (state.isFilterApplied) return Icons.list;
    return Icons.task_alt;
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            infoIcon,
            size: 100,
            color: context.theme.colorScheme.primary.withAlpha(180),
          ),
          const SizedBox(height: 8),
          TextWidget(
            infoText,
            style: context.theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.theme.colorScheme.onSurface,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          if (!state.isFilterApplied)
            TextWidget(
              'Add your tasks and stay organized.',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodyLarge?.copyWith(
                color: context.theme.colorScheme.onSurface.withAlpha(180),
              ),
            ),
          const SizedBox(height: 16),
          if (!state.isFilterApplied)
            BorderedRoundedButtonWidget(
              semanticHint: 'Double tap to create your first task',
              semanticLabel: 'Add your first task',
              onTap: () => context.pushTo(
                const TaskCreationOrUpdationPage(
                  saveButtonTag: WidgetIdentifier.initalTaskAddButton,
                ),
              ),
              label: 'ADD YOUR TASK',
              key: WidgetIdentifier.initalTaskAddButton.key,
              icon: Icons.add_task_outlined,
              heroTag: WidgetIdentifier.initalTaskAddButton,
              iconColor: context.theme.primaryColor,
            ),
        ],
      ),
    );
  }
}
