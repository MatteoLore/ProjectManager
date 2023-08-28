import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_manager/screens/project.dart';
import 'package:project_manager/widgets/addedit_task_dialog.dart';

import '../models/Project.dart';
import '../models/Task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Project project;
  final ProjectPageState page;

  List<List<Widget>> status = [
    [Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("In waiting", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))],
    [Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orangeAccent,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("In progress", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))],
    [Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("Completed", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))],
  ];

  TaskCard({super.key, required this.task, required this.project, required this.page});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context,
        void Function(void Function()) setState) {
      return MaterialButton(onPressed: () {
        showDialog(context: context, builder: (BuildContext context) {
          return AddEditTaskDialog(task: task);
        }).then((value) {
          setState(() {
            project.sortTask();
            project.getStatus();
            page.setState(() {

            });
          });
        });
      },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(padding: EdgeInsets.all(20), child: Column(
              children: [
                Text(task.name),
                Padding(child: Container(
                  height: 5, decoration: BoxDecoration(color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],),), padding: EdgeInsets.all(10)),
                Expanded(child: Text(task.description), flex: 2,),
                Padding(child: Container(
                  height: 5, decoration: BoxDecoration(color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],),), padding: EdgeInsets.all(10)),
                Padding(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: status[task.status]),
                  padding: EdgeInsets.all(10),)
              ],
            ))
        ),
      );
    });
  }

}