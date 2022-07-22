// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:m_one/Features/landing_page/manager/landing_page_bloc.dart';
import 'package:m_one/Features/landing_page/preview/widgets/task_details.dart';
import 'package:m_one/core/models/task_model.dart';

class TaskWidget extends StatelessWidget {
  TaskModel taskModel;
  LandingPageBloc landingPageBloc;
  List<TaskModel> taskModelList;
  String taskGroupTag;
  bool sortByDate;
  TaskWidget({
    required this.taskModel,
    required this.landingPageBloc,
    required this.taskModelList,
    required this.sortByDate,
    required this.taskGroupTag,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: taskGroupTag,
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          Expanded(
            child: Center(
              child: IconButton(
                  onPressed: () => (landingPageBloc.add(
                        LandingPageRemoveTaskEvent(taskModel),
                      )),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  )),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          showDialog(context: context, builder: (context) => TaskDetails(landingPageBloc, taskModel, taskModelList, sortByDate));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.blue,
                  child: Text(
                    taskModel.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Description:"),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          taskModel.description,
                          maxLines: 10,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text("Last Modified: ${convertedDateTime(taskModel.lastModifiedDateTime)}"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convertedDateTime(DateTime dateTime) {
    return "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
