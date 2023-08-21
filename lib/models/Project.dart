import 'Task.dart';

class Project {
  final String id;
  final String authorId;
  final String name;
  final String description;
  final List<Task> tasks;
  final int status;
  final DateTime dateTime;
  final List<String> contributorsIds;
  late List<Task> pendingTasks;
  late List<Task> currentTasks;
  late List<Task> tasksCompleted;

  Project({
    required this.id,
    required this.authorId,
    required this.name,
    required this.description,
    required this.tasks,
    required this.status,
    required this.dateTime,
    required this.contributorsIds
  });
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