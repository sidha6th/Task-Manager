import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/enums/tooltip_and_semantics.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/shrink_effect_wrapper.dart';
import 'package:task_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager/features/home/presentation/bloc/home_state.dart';

class AddTaskFABButtonWidget extends StatelessWidget {
  const AddTaskFABButtonWidget({required this.onTap, super.key});

  final void Function(WidgetIdentifier tag) onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (!state.isFilterApplied && (state.loading || !state.hasData)) {
        return const SizedBox.shrink();
      }

      return ShrinkEffectWrapper(
        tapDownScale: 0.9,
        tooltipOrSemantics: ToolTipOrSemantics.addTask,
        child: FloatingActionButton(
          key: WidgetIdentifier.taskAddFAButton.key,
          onPressed: () => onTap(WidgetIdentifier.taskAddFAButton),
          enableFeedback: true,
          heroTag: WidgetIdentifier.taskAddFAButton.name,
          tooltip: ToolTipOrSemantics.addTask.toolTip,
          child: Icon(
            Icons.add,
            color: context.theme.primaryColor,
          ),
        ),
      );
    });
  }
}
