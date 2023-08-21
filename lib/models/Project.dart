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

}