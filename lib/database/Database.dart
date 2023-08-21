import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Project.dart';
import '../models/User.dart';

class Database {
  final CollectionReference projectsCollection = FirebaseFirestore.instance.collection("projects");
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");

  Stream<List<Project>> getProjects() {
    return projectsCollection
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Project(
          id: doc["id"],
          authorId: doc["authorId"],
          name: doc["authorId"],
          description: doc["description"],
          tasks: doc["tasks"],
          status: doc["status"],
          dateTime: doc["dateTime"],
          contributorsIds: doc["contributorsIds"]
        );
      }).toList();
    });
  }

  Future<Project?> getProjectById(String projectId) async {
    try {
      DocumentSnapshot projectSnapshot =
      await projectsCollection.doc(projectId).get();

      if (projectSnapshot.exists) {
        Map<String, dynamic> data = projectSnapshot.data() as Map<String, dynamic>;
        return Project(
          id: projectSnapshot.id,
          authorId: data["authorId"],
          name: data["name"],
          description: data["description"],
          tasks: data["tasks"],
          status: data["status"],
          dateTime: data["dateTime"],
          contributorsIds: data["contributorsIds"],
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addProject(Project project) async {
    try {
      await projectsCollection.add({
        "authorId": project.authorId,
        "name": project.name,
        "description": project.description,
        "tasks": project.tasks,
        "status": project.status,
        "dateTime": project.dateTime,
        "contributorsIds": project.contributorsIds,
      });
    } catch (e) {
      print(e);
    }
  }


  Stream<List<User>> getUsers() {
    return usersCollection
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return User(
          id: doc["id"],
          username: doc["username"],
          avatarUrl: doc["avatarUrl"],
          projectsIds: doc["projectsIds"],
          ownerProjectsIds: doc["ownerProjectsIds"],
        );
      }).toList();
    });
  }

  Future<User?> getUserById(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
      await usersCollection.doc(userId).get();

      if (userSnapshot.exists) {
        return User(
          id: userSnapshot.id,
          username: userSnapshot["username"],
          avatarUrl: userSnapshot["avatarUrl"],
          projectsIds: userSnapshot["projectsIds"],
          ownerProjectsIds: userSnapshot["ownerProjectsIds"],
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addUser(User user) async {
    try {
      await usersCollection.add({
        "username": user.username,
        "avatarUrl": user.avatarUrl,
        "projectsIds": user.projectsIds,
        "ownerProjectsIds": user.ownerProjectsIds,
      });
    } catch (e) {
      print(e);
    }
  }

}