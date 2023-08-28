import 'package:firedart/firedart.dart';

import '../models/Project.dart';
import '../models/User.dart';

class Database {
  final CollectionReference projectsCollection = Firestore.instance.collection("projects");
  final CollectionReference usersCollection = Firestore.instance.collection("users");

  Future<List<Project>> getProjects() async {
    List<Document> projects = await projectsCollection.orderBy("createdAt", descending: true).get();
      return projects.map((doc) {
        var data = doc.map;
        return Project(
          id: doc.id,
          authorId: data["authorId"],
          name: data["authorId"],
          description: data["description"],
          tasks: data["tasks"],
          status: data["status"],
          dateTime: data["dateTime"],
          contributors: data["contributors"],
          bannerUrl: data["bannerUrl"]
        );
      }).toList();
  }

  Future<Project?> getProjectById(String projectId) async {
    try {
      DocumentReference projectSnapshot = projectsCollection.document(projectId);

      if (await projectSnapshot.exists) {
        Map<String, dynamic> data = await projectSnapshot.get() as Map<String, dynamic>;
        return Project(
          id: projectSnapshot.id,
          authorId: data["authorId"],
          name: data["name"],
          description: data["description"],
          tasks: data["tasks"],
          status: data["status"],
          dateTime: data["dateTime"],
          contributors: data["contributors"],
          bannerUrl: data["bannerUrl"]
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
  Future<void> updateProject(Project project, String jsonTask) async {
    try {
      await projectsCollection.document(project.id).update({
        "authorId": project.authorId,
        "name": project.name,
        "description": project.description,
        "tasks": jsonTask,
        "dateTime": project.dateTime,
        "contributors": project.contributorsId,
        "bannerUrl": project.bannerUrl
      });
    }catch (e){
      print(e);
    }
  }

  Future<List<User>> getUsers() async {
    List<Document> users = await usersCollection.orderBy("createdAt", descending: true).get();
    return users.map((doc) {
      var data = doc.map;
      return User(
        id: doc.id,
        username: data["username"],
        avatarUrl: data["avatarUrl"],
        projectsIds: data["projectsIds"],
        ownerProjectsIds: data["ownerProjectsIds"],
      );
    }).toList();
  }

  Future<User?> getUserByEmail(String email) async {
    try {
      DocumentReference userSnapshot = usersCollection.document(email);

      if (await userSnapshot.exists) {
        Map<String, dynamic> data = await userSnapshot.get() as Map<String, dynamic>;
        return User(
          id: userSnapshot.id,
          username: data["username"],
          avatarUrl: data["avatarUrl"],
          projectsIds: data["projectsIds"],
          ownerProjectsIds: data["ownerProjectsIds"],
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> addUser(User user, String email) async {
    try {
      await usersCollection.add({
        "username": user.username,
        "avatarUrl": user.avatarUrl,
        "projectsIds": user.projectsIds,
        "ownerProjectsIds": user.ownerProjectsIds,
        "email": email
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await usersCollection.document(user.id).update({
        "username": user.username,
        "avatarUrl": user.avatarUrl,
        "projectsIds": user.projectsIds,
        "ownerProjectsIds": user.ownerProjectsIds,
      });
    }catch (e){
      print(e);
    }
  }

}