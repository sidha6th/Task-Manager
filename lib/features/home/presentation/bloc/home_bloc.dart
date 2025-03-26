import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/extension/bool_extension.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/features/home/data/repository/home_repository.dart';
import 'package:task_manager/features/home/presentation/bloc/home_event.dart';
import 'package:task_manager/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<IHomeEvent, HomeState> {
  HomeBloc(this.repository) : super(const HomeState.loading()) {
    on<LoadTasksEvent>(onLoadTasksEvent);
    on<DeleteTaskEvent>(onDeleteTaskEvent);
    on<ToggleTaskStatusEvent>(onToggleTaskStatusEvent);
    on<UndoDeletedTaskEvent>(onUndoLastDeletedTaskEvent);
    on<SelectTaskEvent>(onSelectTaskEvent);
  }

  final HomeRepository repository;
  StreamSubscription<List<Task>>? _streamSubscription;

  Future<void> onLoadTasksEvent(
    LoadTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (!event.resetPage && (state.isNextPageLoading || state.hasGotAllData)) {
      return;
    }

    final filterSettings = state.filterSettings.copyLatest(
      event.filterSettings,
    );

    if (state.filterSettings != filterSettings && event.resetPage) {
      await _streamSubscription?.cancel();
      emit(state.toLoading(filterSettings: filterSettings));
    }

    if (!state.initialPage) emit(state.toNextPageLoading());

    final completer = Completer<void>();

    final tasksStream = repository.watchTasks(
      state.page,
      filterSettings: filterSettings,
    );

    emit(state.copyWith(page: state.page + 1));

    _streamSubscription = tasksStream.listen(
      (data) {
        final tasks = event.resetPage.then(() => data, or: () {
          return [...state.data ?? <Task>[], ...data];
        });
        emit(
          state.toSuccess(
            task: tasks,
            hasGotAllData: data.isEmpty,
            currentlySelectedTask: state.currentlySelectedTask,
          ),
        );
      },
      onDone: completer.complete,
      onError: completer.completeError,
    );

    await completer.future;
  }

  void onDeleteTaskEvent(
    DeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) {
    if (state.data == null || state.data!.isEmpty) return;
    final task = state.data![event.index];
    repository.delete(task);
    state.data!.removeAt(event.index);
    emit(state.toSuccess(
      lastDeletedTask: task,
      currentlySelectedTask: task.id == state.currentlySelectedTask?.id
          ? null
          : state.currentlySelectedTask,
    ));
    event.whenCompleted?.call(task);
  }

  Future<void> onUndoLastDeletedTaskEvent(
    UndoDeletedTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    final lastSelectedTask =
        (event.task.id == state.currentlySelectedTask?.id).then(
      () => event.task,
      or: () => null,
    );
    await repository.createOrUpdate(event.task);
    emit(state.toSuccess(currentlySelectedTask: lastSelectedTask));
  }

  void onSelectTaskEvent(
    SelectTaskEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(state.toSuccess(currentlySelectedTask: event.task));
  }

  void onToggleTaskStatusEvent(
    ToggleTaskStatusEvent event,
    Emitter<HomeState> emit,
  ) {
    final task = event.task.statusToggledTask();
    repository.createOrUpdate(task);
    if (state.currentlySelectedTask?.id == task.id) {
      emit(state.toSuccess(currentlySelectedTask: task));
    }
    event.whenCompleted?.call(task);
  }
}
