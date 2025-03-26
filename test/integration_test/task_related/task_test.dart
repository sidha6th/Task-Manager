import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/models/task/task_filters.dart';
import 'package:task_manager/core/global/models/task/task_priorities.dart';
import 'package:task_manager/core/global/models/task/task_sort_options.dart';
import 'package:task_manager/features/home/presentation/widgets/task_tile_widget.dart';

import 'helpers/create_task_helper.dart';
import 'helpers/navigate_create_task_page.dart';
import 'helpers/open_filter_test.dart';
import 'helpers/setup.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group(
    'Task creation flow',
    () {
      testWidgets(
        'Create new task with all fields filled',
        (WidgetTester tester) async {
          await initTest(binding);
          await tester.pump();
          await tester.pumpAndSettle();
          await navigateToCreateTaskPage(tester);
          final task = Task.create(
            title: 'Task 1',
            duedate: DateTime.now(),
            priority: TaskPriority.high,
          );
          await createTaskTest(tester, task);
          await tester.pumpAndSettle();

          expect(find.text(task.title), findsWidgets);
        },
      );
      testWidgets(
        'Filter tasks by status (Completed/Pending)',
        (WidgetTester tester) async {
          await initTest(binding);
          await tester.pump();
          await tester.pumpAndSettle();

          // Create tasks with different priorities
          final now = DateTime.now();

          await navigateToCreateTaskPage(tester);

          await createTaskTest(
            tester,
            Task.create(
              duedate: now,
              title: 'Pending Task',
              priority: TaskPriority.high,
            ),
          );

          // Open filter menu
          await openFilter(
            tester,
            () async {
              await tester.tap(find.byKey(ValueKey(TaskFilters.pending.name)));
              await tester.pump();
              await tester.pumpAndSettle();
            },
          );
          await tester.pump();
          await tester.pumpAndSettle(const Duration(milliseconds: 500));

          final tiles = find.byType(TaskListTile);
          final widgets = tester.widgetList<TaskListTile>(tiles);
          final inProgressTaskTiles =
              widgets.where((e) => e.task.status.isInProgress);
          final completedTasks =
              widgets.where((e) => e.task.status.isCompleted);
          expect(inProgressTaskTiles.isNotEmpty, true,
              reason: 'Should find atleast on task in progress');
          expect(completedTasks.isEmpty, true,
              reason: 'completed tasks shouldn\'t be found');

          await tester.tap(tiles.first);
          await tester.pumpAndSettle();
          await tester
              .tap(find.byKey(WidgetIdentifier.statusTogglingButton.key));
          await tester.pumpAndSettle();

          final backButton = find.byTooltip('Back');
          if (tester.any(backButton)) {
            await tester.tap(backButton);
            await tester.pumpAndSettle();
          }

          await openFilter(
            tester,
            () async {
              await tester
                  .tap(find.byKey(ValueKey(TaskFilters.completed.name)));
              await tester.pump();
              await tester.pumpAndSettle();
            },
          );

          final newTiles =
              tester.widgetList<TaskListTile>(find.byType(TaskListTile));
          final newInProgressTaskTiles =
              newTiles.where((e) => e.task.status.isInProgress);
          final newCompletedTasks =
              newTiles.where((e) => e.task.status.isCompleted);
          expect(newCompletedTasks.isNotEmpty, true,
              reason: 'Should find atleast on task in progress');
          expect(newInProgressTaskTiles.isEmpty, true,
              reason: 'completed tasks shouldn\'t be found');
        },
      );
      testWidgets(
        'Sort tasks by priority and verify order',
        (WidgetTester tester) async {
          await initTest(binding);
          await tester.pump();
          await tester.pumpAndSettle();

          // Create tasks with different priorities
          final now = DateTime.now();
          final tasks = [
            Task.create(
              duedate: now,
              title: 'Low Priority Task',
              priority: TaskPriority.low,
            ),
            Task.create(
              duedate: now,
              title: 'High Priority Task',
              priority: TaskPriority.high,
            ),
            Task.create(
              duedate: now,
              title: 'Medium Priority Task',
              priority: TaskPriority.medium,
            ),
          ];

          // Create each task
          for (final task in tasks) {
            await navigateToCreateTaskPage(tester);
            await createTaskTest(tester, task);
            await tester.pumpAndSettle();
          }

          // Open filter/sort menu
          await openFilter(
            tester,
            () async {
              // Tap the priority sort option
              await tester
                  .tap(find.byKey(ValueKey(TaskSortOptions.priority.name)));
              await tester.pump();
              await tester.pumpAndSettle();
            },
          );

          // Get all task tiles after sorting
          final tiles = tester.widgetList<TaskListTile>(
            find.byType(TaskListTile),
          );
          final indexOrders = <int>[];
          for (var element in tiles) {
            final priorityIndex = element.task.priority.index;
            if (indexOrders.contains(priorityIndex)) continue;
            if (indexOrders.length == TaskPriority.values.length) break;
            indexOrders.add(priorityIndex);
          }

          for (var priority in TaskPriority.values) {
            expect(priority.index, indexOrders[priority.index]);
          }
        },
      );
    },
  );
}
