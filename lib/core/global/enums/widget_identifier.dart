import 'package:flutter/widgets.dart';

enum WidgetIdentifier {
  initalTaskAddButton,
  taskAddFAButton,
  taskEditButton,
  primaryColorIndicator,
  themModeChangingTile,
  primaryColorChanginTile,
  dueDateSelector,
  filterApplyButton,
  taskSearchTextField,
  statusTogglingButton,
  taskSaveButton;

  ValueKey get key => ValueKey(this);
}
