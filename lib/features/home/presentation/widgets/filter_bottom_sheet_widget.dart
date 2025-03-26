import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_navigation_extension.dart';
import 'package:task_manager/core/global/models/task/task_filter_settings.dart';
import 'package:task_manager/core/global/models/task/task_filters.dart';
import 'package:task_manager/core/global/models/task/task_sort_options.dart';
import 'package:task_manager/core/global/widgets/button/bordered_rounded_button.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  const FilterBottomSheetWidget({
    required this.selectedFilter,
    required this.selectedSort,
    required this.onApply,
    super.key,
  });

  final TaskFilters selectedFilter;
  final TaskSortOptions selectedSort;
  final Function(TaskFilterSettings settings) onApply;

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late TaskFilters selectedFilter = widget.selectedFilter;
  late TaskSortOptions selectedSort = widget.selectedSort;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const TextWidget('Filter & Sort Tasks'),
              Semantics(
                hint: 'double tap to close filter',
                child: ExcludeSemantics(
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
          Semantics(
            label: 'Filter the tasks by selecting any of the below',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget('Filter by Status'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 8,
                    children: TaskFilters.values.map((filter) {
                      final selected = selectedFilter == filter;
                      return Semantics(
                        selected: selected,
                        hint: selected
                            ? filter.name
                            : 'Double tap to filter by ${filter.name}',
                        child: ExcludeSemantics(
                          child: ChoiceChip(
                            key: ValueKey(filter.name),
                            label: TextWidget(filter.name),
                            selected: selected,
                            onSelected: (bool selected) {
                              if (selected) {
                                setState(() => selectedFilter = filter);
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Semantics(
            label: 'Sort the tasks by selecting any of the below',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget('Sort by'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 8,
                    children: TaskSortOptions.values.map((sort) {
                      final selected = selectedSort == sort;
                      return Semantics(
                        selected: selected,
                        hint: selected
                            ? sort.name
                            : 'Double tap to sort by ${sort.name}',
                        child: ExcludeSemantics(
                          child: ChoiceChip(
                            key: ValueKey(sort.name),
                            label: TextWidget(sort.name),
                            selected: selected,
                            onSelected: (bool selected) {
                              if (selected) {
                                setState(() => selectedSort = sort);
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: BorderedRoundedButtonWidget(
                label: 'Apply',
                semanticHint: 'Double tap to apply the filter',
                onTap: _onTapApply,
                borderThickness: 2,
                icon: Icons.auto_awesome,
                key: WidgetIdentifier.filterApplyButton.key,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapApply() {
    if (selectedFilter == widget.selectedFilter &&
        selectedSort == widget.selectedSort) {
      return context.pop();
    }
    final filter = TaskFilterSettings.fromFilter(
      sortBy: selectedSort,
      filterBy: selectedFilter,
    );
    widget.onApply(filter);
    context.pop();
  }
}
