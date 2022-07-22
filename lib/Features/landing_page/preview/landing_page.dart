// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:m_one/Features/landing_page/manager/landing_page_bloc.dart';
import 'package:m_one/Features/landing_page/preview/widgets/add_task_fields.dart';
import 'package:m_one/Features/landing_page/preview/widgets/task_widget.dart';
import 'package:m_one/core/models/task_model.dart';

class LandingPage extends StatelessWidget {
  LandingPageBloc landingPageBloc = LandingPageBloc();
  bool sortByDate = true;
  late LandingPageStateTasksLoadedState currentState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Todo List"), actions: [popupMenuButton()]),
      body: BlocProvider(
        create: (context) => landingPageBloc..add(LandingPageLoadTasksEvent()),
        child: BlocBuilder<LandingPageBloc, LandingPageState>(builder: (context, state) {
          if (state is LandingPageStateTasksLoadedState) {
            currentState = state;
            String taskGroupTag = "taskGroupTag";
            List<Widget> tasksList = state.list.values
                .map(
                  (task) => TaskWidget(
                    taskModel: task,
                    landingPageBloc: landingPageBloc,
                    taskModelList: state.list.values.toList(),
                    sortByDate: sortByDate,
                    taskGroupTag: taskGroupTag,
                  ),
                )
                .toList();
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SlidableAutoCloseBehavior(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: tasksList,
                ),
              ),
            );
          } else if (state is LandingPageStateTasksLoadingState ||
              state is LandingPageStateTaskAddingState ||
              state is LandingPageStateTaskRemovingState ||
              state is LandingPageStateTaskSortingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              color: Colors.red,
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addTaskDialog(context, currentState.list.values.toList()),
        child: const Icon(Icons.add),
      ),
    );
  }

  void addTaskDialog(BuildContext context, List<TaskModel> taskModelList) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return AddTaskFields(landingPageBloc, taskModelList, sortByDate);
        });
  }

  PopupMenuButton popupMenuButton() {
    List<String> optionList = ["Sort by Name", "Sort by Date"];
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return optionList.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      onSelected: (item) {
        sortByDate = item == "Sort by Date";
        landingPageBloc.add(LandingPageSortTasksByDateEvent(sortByDate));
      },
    );
  }
}
