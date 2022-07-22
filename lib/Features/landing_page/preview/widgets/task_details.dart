// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:m_one/Features/landing_page/manager/landing_page_bloc.dart';
import 'package:m_one/Features/landing_page/preview/widgets/custom_text_field_decoration.dart';
import 'package:m_one/Features/landing_page/preview/widgets/dialog_buttons.dart';
import 'package:m_one/core/models/task_model.dart';

class TaskDetails extends StatelessWidget {
  LandingPageBloc landingPageBloc;
  TaskModel oldTaskModel;
  List<TaskModel> taskModelList;
  bool sortByDate;
  TaskDetails(
    this.landingPageBloc,
    this.oldTaskModel,
    this.taskModelList,
    this.sortByDate,
  );
  late final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController()..text = oldTaskModel.title;
    TextEditingController descriptionController = TextEditingController()..text = oldTaskModel.description;
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: ((value) => (value == null || value.isEmpty)
                  ? 'Please enter some text'
                  : (taskModelList.indexWhere((element) => element.title == value && value != oldTaskModel.title) != -1)
                      ? 'A task with this title exists'
                      : null),
              decoration: customTextFieldInputDecoration("Task title"),
              maxLines: 1,
              maxLength: 30,
              controller: titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: ((value) => (value == null || value.isEmpty) ? 'Please enter some text' : null),
              decoration: customTextFieldInputDecoration("Task description"),
              minLines: 1,
              maxLines: 10,
              maxLength: 500,
              controller: descriptionController,
            ),
          ],
        ),
      ),
      actions: [
        dialogButton("Update", () {
          if (_formKey.currentState!.validate()) {
            landingPageBloc.add(
              LandingPageUpdateTaskEvent(
                oldTaskModel,
                TaskModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  completed: false,
                  lastModifiedDateTime: DateTime.now(),
                ),
                sortByDate,
              ),
            );
            Navigator.of(context).pop();
          }
        }),
        dialogButton("Complete", () {
          if (_formKey.currentState!.validate()) {
            landingPageBloc.add(
              LandingPageRemoveTaskEvent(
                oldTaskModel,
              ),
            );
            Navigator.of(context).pop();
          }
        }),
        dialogButton("cancel", () => Navigator.of(context).pop()),
      ],
    );
  }
}
