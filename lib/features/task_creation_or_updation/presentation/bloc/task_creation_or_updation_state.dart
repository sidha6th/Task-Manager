import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/state/global_bloc_state.dart';

base class TaskCreationOrUpdationState extends GlobalBlocState<Task> {
  const TaskCreationOrUpdationState.nil() : super.nil();
  const TaskCreationOrUpdationState.error() : super.error();
  const TaskCreationOrUpdationState.success(super.value) : super.success();
  const TaskCreationOrUpdationState.loading() : super.loading();
}
