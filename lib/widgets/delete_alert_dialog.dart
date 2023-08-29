import 'package:flutter/material.dart';
import 'package:project_manager/models/Project.dart';
import 'package:project_manager/models/Task.dart';

class DeleteAlertDialog extends AlertDialog {

  final dynamic object;

  late String name;
  late String type;
  late void delete;

  DeleteAlertDialog({super.key, required this.object}){

    switch (object.runtimeType){
      case Project:
        Project project = object as Project;
        type = "project";
        name = project.name;
        delete = project.delete();
        break;
      case Task:
        Task task = object as Task;
        type = "task";
        name = task.name;
        break;
      default:
        name = "Unknown object";
        type = "Unknown object";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Remove the $type"),
      content: Text("Remove this $type : $name ?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("No"),
        ),
        TextButton(
          onPressed: () {
            delete;
            Navigator.pop(context);
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}