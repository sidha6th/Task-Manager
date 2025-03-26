enum ToolTipOrSemantics {
  addTask('Add Task', 'Add new task'),
  editTask('Edit Task'),
  settings('Settings'),
  filter('Filter');

  const ToolTipOrSemantics(
    this.toolTip, [
    this._semantics,
  ]);

  final String toolTip;
  final String? _semantics;

  String get semanticLabel => _semantics ?? toolTip;
}
