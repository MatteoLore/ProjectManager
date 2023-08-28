import 'dart:convert';
import 'package:project_manager/models/User.dart';

import 'Task.dart';

class Project {
  final String id;
  final String authorId;
  String name;
  String description;
  List<Task> tasks;
  DateTime dateTime;
  List<String> contributorsId;
  String bannerUrl;

  List<Task> pendingTasks = [];
  List<Task> currentTasks = [];
  List<Task> tasksCompleted = [];
  int status = 0;


  Project({
    required this.id,
    required this.authorId,
    required this.name,
    required this.description,
    required this.tasks,
    required this.dateTime,
    required this.contributorsId,
    required this.bannerUrl
  }) {

    // Sort tasks by status
    for(var task in tasks){
      switch (task.status){
        case 0:
          pendingTasks.add(task);
          break;
        case 1:
          currentTasks.add(task);
          break;
        default:
          tasksCompleted.add(task);
      }
    }
  }

}