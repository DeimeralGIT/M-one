// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:m_one/Features/landing_page/manager/landing_page_bloc.dart';
import 'package:m_one/Features/landing_page/preview/widgets/custom_text_field_decoration.dart';
import 'package:m_one/core/models/task_model.dart';

import 'dialog_buttons.dart';

class AddTaskFields extends StatelessWidget {
  LandingPageBloc landingPageBloc;
  List<TaskModel> taskModelList;
  AddTaskFields(this.landingPageBloc, this.taskModelList);
  late final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: ((value) => (value == null || value.isEmpty)
                  ? 'Please enter some text'
                  : (taskModelList.indexWhere((element) => element.title == value) != -1)
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
        dialogButton("Save", () {
          if (_formKey.currentState!.validate()) {
            landingPageBloc.add(
              LandingPageAddTaskEvent(
                TaskModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  completed: false,
                  lastModifiedDateTime: DateTime.now(),
                ),
              ),
            );
            Navigator.of(context).pop();
          }
        }),
        dialogButton("Cancel", () => Navigator.of(context).pop()),
      ],
    );
  }
}
