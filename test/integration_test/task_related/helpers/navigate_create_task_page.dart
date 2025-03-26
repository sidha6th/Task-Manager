import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';

Future<void> navigateToCreateTaskPage(WidgetTester tester) async {
  // Find and tap the add task initial add button
  final addTaskRoundedButton = find.byKey(
    WidgetIdentifier.initalTaskAddButton.key,
  );

  // Find and tap the add task FAB
  final addTaskFAButton = find.byKey(
    WidgetIdentifier.taskAddFAButton.key,
  );

  if (tester.any(addTaskFAButton)) {
    await tester.tap(addTaskFAButton);
  } else if (tester.any(addTaskRoundedButton)) {
    await tester.tap(addTaskRoundedButton);
  }

  await tester.pump();
  await tester.pumpAndSettle();
}
