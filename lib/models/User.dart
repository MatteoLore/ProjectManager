import 'package:project_manager/database/Database.dart';

class User {
  final String id;
  String username;
  String avatarUrl;
  List<String> projectsIds;
  List<String> ownerProjectsIds;

  User({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.projectsIds,
    required this.ownerProjectsIds
  }) {
    projectsIds = projectsIds.toList();
    ownerProjectsIds = ownerProjectsIds.toList();
  }

  void save() {
    Database db = Database();
    db.updateUser(this);
  }
}