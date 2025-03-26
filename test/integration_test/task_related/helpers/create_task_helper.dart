import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/global/enums/date_formates.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/date_time_extension.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/widgets/segmented_priority_selector.dart';

Future<void> createTaskTest(WidgetTester tester, Task task) async {
  await tester.pump(const Duration(seconds: 1));
  final titleField = find.byType(TextFormField).first;
  await tester.enterText(titleField, task.title);
  await tester.pumpAndSettle();

  // Fill in description
  final descriptionField = find.byType(TextFormField).at(1);
  await tester.enterText(descriptionField, task.description ?? '');
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(WidgetIdentifier.dueDateSelector.key));
  await tester.pumpAndSettle();

  final now = DateTime.now();
  if (task.duedate.year != now.year) {
    // Tap the header to show year picker
    await tester.tap(find.text(now.year.toString()));
    await tester.pumpAndSettle();

    // Select the year
    await tester.tap(find.text(task.duedate.year.toString()));
    await tester.pumpAndSettle();
  }

  // Navigate to correct month
  final currentMonth = find.text(now.format(DateFormates.MMMMyyyy));
  final targetMonth = find.text(task.duedate.format(DateFormates.MMMMyyyy));

  while (tester.any(currentMonth) && !tester.any(targetMonth)) {
    if (task.duedate.isAfter(now)) {
      await tester.tap(find.byIcon(Icons.chevron_right));
    } else {
      await tester.tap(find.byIcon(Icons.chevron_left));
    }
    await tester.pumpAndSettle();
  }

  // Select the day
  await tester.tap(find.text(task.duedate.day.toString()).last);
  await tester.pumpAndSettle();

  // Select a date from date picker
  final datePickerOkButton = find.text('OK');
  await tester.tap(datePickerOkButton);
  await tester.pumpAndSettle();

  // Select priority
  final prioritySelector = find.byType(PrioritySegmentedSelector);
  await tester.tap(prioritySelector);
  await tester.pumpAndSettle();
  await tester.tap(find.text(task.priority.name));
  await tester.pumpAndSettle();

  // Save task
  final saveButton = find.byKey(WidgetIdentifier.taskSaveButton.key);
  await tester.tap(saveButton);
  await tester.pumpAndSettle();
}
