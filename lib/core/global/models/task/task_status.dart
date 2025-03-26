enum TaskStatus {
  completed,
  inprogress;

  bool get isCompleted => this == TaskStatus.completed;
  bool get isInProgress => this == TaskStatus.inprogress;
}
