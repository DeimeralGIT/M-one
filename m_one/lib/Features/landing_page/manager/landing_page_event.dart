part of 'landing_page_bloc.dart';

abstract class LandingPageEvent {}

class LandingPageLoadTasksEvent extends LandingPageEvent {}

class LandingPageFetchTasksEvent extends LandingPageEvent {
  Map<String, TaskModel> list;
  LandingPageFetchTasksEvent(this.list);
}

class LandingPageAddTaskEvent extends LandingPageEvent {
  TaskModel taskModel;
  LandingPageAddTaskEvent(this.taskModel);
}

class LandingPageRemoveTaskEvent extends LandingPageEvent {
  TaskModel taskModel;
  LandingPageRemoveTaskEvent(this.taskModel);
}

class LandingPageUpdateTaskEvent extends LandingPageEvent {
  TaskModel oldTaskModel;
  TaskModel newTaskModel;
  LandingPageUpdateTaskEvent(this.oldTaskModel, this.newTaskModel);
}

class LandingPageSortTasksByDateEvent extends LandingPageEvent {
  bool byDate;
  LandingPageSortTasksByDateEvent(this.byDate);
}
