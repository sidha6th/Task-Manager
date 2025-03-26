import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task_creation_or_updation/data/repository/task_creation_or_updation_repository.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/bloc/task_creation_or_updation_event.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/bloc/task_creation_or_updation_state.dart';

class TaskCreationOrUpdationBloc
    extends Bloc<ITaskCreationOrUpdationEvent, TaskCreationOrUpdationState> {
  TaskCreationOrUpdationBloc(this.repository)
      : super(const TaskCreationOrUpdationState.nil()) {
    on<CreateOrUpdateTaskEvent>(_addOrUpdateEvent);
  }

  final TaskCreationOrUpdationRepository repository;

  Future<void> _addOrUpdateEvent(
    CreateOrUpdateTaskEvent event,
    Emitter<TaskCreationOrUpdationState> emit,
  ) async {
    emit(const TaskCreationOrUpdationState.loading());
    await repository.createOrUpdateTask(event.task);
    emit(TaskCreationOrUpdationState.success(event.task));
    event.whenCompleted?.call(event.task);
  }
}
