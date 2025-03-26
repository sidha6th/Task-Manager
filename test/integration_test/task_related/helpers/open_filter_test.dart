import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/global/enums/tooltip_and_semantics.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';

Future<void> openFilter(
  WidgetTester tester,
  Future<void> Function() whenOpened,
) async {
  // opening the filter sheet
  final filterButton = find.byTooltip(ToolTipOrSemantics.filter.toolTip);
  await tester.tap(filterButton);
  await tester.pumpAndSettle();

  // exicuting filter action
  await whenOpened();
  await tester.pumpAndSettle();

  // apply button tap, will close the filter sheet
  await tester.tap(find.byKey(WidgetIdentifier.filterApplyButton.key));
  await tester.pumpAndSettle(const Duration(milliseconds: 300));
}
