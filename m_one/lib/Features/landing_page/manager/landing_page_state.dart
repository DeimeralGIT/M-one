part of 'landing_page_bloc.dart';

abstract class LandingPageState {}

class LandingPageStateInitial extends LandingPageState {}

class LandingPageStateTasksLoadingState extends LandingPageState {}

class LandingPageStateTasksLoadedState extends LandingPageState {
  Map<String, TaskModel> list;
  LandingPageStateTasksLoadedState(this.list);
}

class LandingPageStateTaskAddingState extends LandingPageState {}

class LandingPageStateTaskRemovingState extends LandingPageState {}

class LandingPageStateTaskSortingState extends LandingPageState {}
