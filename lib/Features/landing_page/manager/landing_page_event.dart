part of 'landing_page_bloc.dart';

abstract class LandingPageEvent {}

class LandingPageLoadTasksEvent extends LandingPageEvent {}

class LandingPageFetchTasksEvent extends LandingPageEvent {
  Map<String, TaskModel> list;
  LandingPageFetchTasksEvent(this.list);
}

class LandingPageAddTaskEvent extends LandingPageEvent {
  TaskModel taskModel;
  bool sortByDate;
  LandingPageAddTaskEvent(this.taskModel, this.sortByDate);
}

class LandingPageRemoveTaskEvent extends LandingPageEvent {
  TaskModel taskModel;
  LandingPageRemoveTaskEvent(this.taskModel);
}

class LandingPageUpdateTaskEvent extends LandingPageEvent {
  TaskModel oldTaskModel;
  TaskModel newTaskModel;
  bool sortByDate;
  LandingPageUpdateTaskEvent(this.oldTaskModel, this.newTaskModel, this.sortByDate);
}

class LandingPageSortTasksByDateEvent extends LandingPageEvent {
  bool byDate;
  LandingPageSortTasksByDateEvent(this.byDate);
}
