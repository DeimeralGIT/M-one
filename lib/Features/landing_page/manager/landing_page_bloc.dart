import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_one/core/data_manager.dart';
import 'package:m_one/core/models/task_model.dart';

part 'landing_page_state.dart';

part 'landing_page_event.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingPageBloc() : super(LandingPageStateInitial()) {
    on<LandingPageLoadTasksEvent>((event, emit) {
      emit(LandingPageStateTasksLoadingState());
      readTasks().then((data) {
        try {
          add(LandingPageFetchTasksEvent(extractTasks(data)));
        } catch (e) {}
      });
    });

    on<LandingPageFetchTasksEvent>((event, emit) {
      emit(LandingPageStateTasksLoadedState(event.list));
    });

    on<LandingPageAddTaskEvent>((event, emit) {
      emit(LandingPageStateTaskAddingState());
      addTask(event.taskModel).then((pass) {
        add(LandingPageSortTasksByDateEvent(event.sortByDate));
      });
    });

    on<LandingPageRemoveTaskEvent>((event, emit) {
      emit(LandingPageStateTaskRemovingState());
      removeTask(event.taskModel).then((pass) {
        add(LandingPageLoadTasksEvent());
      });
    });

    on<LandingPageUpdateTaskEvent>((event, emit) {
      emit(LandingPageStateTaskRemovingState());
      removeTask(event.oldTaskModel).then((pass) {
        add(LandingPageAddTaskEvent(event.newTaskModel, event.sortByDate));
      });
    });

    on<LandingPageSortTasksByDateEvent>((event, emit) {
      emit(LandingPageStateTaskSortingState());
      event.byDate
          ? sortTasksByDate().then((pass) {
              add(LandingPageLoadTasksEvent());
            })
          : sortTasksByName().then((pass) {
              add(LandingPageLoadTasksEvent());
            });
    });
  }
}
