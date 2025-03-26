import 'package:drift/drift.dart';
import 'package:task_manager/core/database/database_client/database.dart';

enum TaskSortOptions {
  alphabetically('Alphabetically'),
  priority('Priority'),
  dueDate('Due Date');

  const TaskSortOptions(this.name);

  final String name;

  bool get isDueDate => this == TaskSortOptions.dueDate;
  bool get isPriority => this == TaskSortOptions.priority;
  bool get isAlphabetically => this == TaskSortOptions.alphabetically;

  /// Returns the corresponding database expression based on the current sort option.
  ///
  /// Takes a [$TaskTableTable] parameter and returns an [Expression<Object>] that
  /// can be used in database queries to sort tasks according to the selected option.
  ///
  /// @param table The task table instance to generate the sort expression from
  /// @return An Expression object representing the sort criteria
  Expression<Object> sortOptionFrom($TaskTableTable table) {
    switch (this) {
      case TaskSortOptions.alphabetically:
        return table.title;
      case TaskSortOptions.dueDate:
        return table.duedate;
      case TaskSortOptions.priority:
        return table.priority;
    }
  }
}
