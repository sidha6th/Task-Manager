import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/tooltip_and_semantics.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/button/icon_button_with_semantics.dart';
import 'package:task_manager/core/global/widgets/text_field/search_field_widget.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    required this.onTapFilter,
    required this.onTapSettings,
    required this.initialSearchValue,
    required this.onChangeSearchQuery,
    required this.isFilterApplied,
    super.key,
  });

  final VoidCallback onTapFilter;
  final VoidCallback onTapSettings;
  final String? initialSearchValue;
  final void Function(String value) onChangeSearchQuery;
  final bool isFilterApplied;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      forceElevated: true,
      forceMaterialTransparency: true,
      excludeHeaderSemantics: true,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: context.viewPadding.top,
        ),
        child: Semantics(
          label: 'Home page',
          header: true,
          child: Row(
            children: [
              Expanded(
                child: SearchFieldWidget(
                  key: WidgetIdentifier.taskSearchTextField.key,
                  hint: 'Search tasks...',
                  prefixIcon: const Icon(Icons.search),
                  onChanged: onChangeSearchQuery,
                  initialValue: initialSearchValue,
                ),
              ),
              Stack(
                children: [
                  IconButtonWithSemantics(
                    onPressed: onTapFilter,
                    icon: const Icon(Icons.filter_list),
                    tooltip: ToolTipOrSemantics.filter.toolTip,
                  ),
                  if (isFilterApplied)
                    Positioned(
                      right: 10,
                      top: 5,
                      child: CircleAvatar(
                        backgroundColor: context.theme.primaryColor,
                        maxRadius: 3,
                      ),
                    )
                ],
              ),
              IconButtonWithSemantics(
                onPressed: onTapSettings,
                icon: const Icon(Icons.settings),
                tooltip: ToolTipOrSemantics.settings.toolTip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
