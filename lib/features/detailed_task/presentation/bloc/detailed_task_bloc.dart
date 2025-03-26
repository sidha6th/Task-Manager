import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/detailed_task/data/repository/detailed_task_repository.dart';
import 'package:task_manager/features/detailed_task/presentation/bloc/detailed_task_event.dart';
import 'package:task_manager/features/detailed_task/presentation/bloc/detailed_task_state.dart';

class DetailedTaskBloc extends Bloc<IDetailedTaskEvent, DetailedTaskState> {
  DetailedTaskBloc(this.repository)
      : super(const DetailedTaskState.success(null)) {
    on<ToggleDetailedTaskStatusEvent>(onToggleTaskStatus);
    on<UpdateDetailedTaskProgressEvent>(onUpdateProgressEvent);
    on<AddDetailedTaskEvent>(onAddDetailedTaskEvent);
  }

  final DetailedTaskRepository repository;

  Future<void> onToggleTaskStatus(
    ToggleDetailedTaskStatusEvent event,
    Emitter<DetailedTaskState> emit,
  ) async {
    emit(state.toLoading());
    await Future.delayed(const Duration(seconds: 1));
    final task = state.data!.statusToggledTask();
    await repository.updateTask(task);
    emit(state.toSuccess(task: task));
    event.whenCompleted?.call(task);
  }

  Future<void> onUpdateProgressEvent(
    UpdateDetailedTaskProgressEvent event,
    Emitter<DetailedTaskState> emit,
  ) async {
    final task = state.data!.progressUpdatedTask(event.progress);
    emit(state.toSuccess(task: task));
    await repository.updateTask(task);
    event.whenCompleted?.call(task);
  }

  void onAddDetailedTaskEvent(
    AddDetailedTaskEvent event,
    Emitter<DetailedTaskState> emit,
  ) {
    emit(state.toSuccess(task: event.task));
  }
}
