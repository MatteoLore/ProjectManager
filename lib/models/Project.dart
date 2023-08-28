import 'dart:convert';

import 'package:project_manager/database/Database.dart';
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
    tasks = tasks.toList();
    contributorsId = contributorsId.toList();


    sortTask();
    getStatus();
  }

  void sortTask() {
    pendingTasks.clear();
    tasksCompleted.clear();
    currentTasks.clear();
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

  void getStatus() {
    if(tasks.isNotEmpty){
      if (tasksCompleted.length == tasks.length) {
        status = 2;
      } else {
        if(pendingTasks.length != tasks.length){
          status = 1;
        }else {
          status = 0;
        }
      }
    }
  }

  void save() {
    Database db = Database();

    String jsonTask = jsonEncode(tasks.map((task) {
      return {"name": task.name, "id": task.id, "status": task.status, "description": task.description};
    }).toList());

    db.updateProject(this, jsonTask);
  }

  static Future<Project> initialize(String authorId) async {
    Database db = Database();
    Project project = await db.addProject(authorId);
    return project;
  }

}