import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:project_manager/models/Task.dart';

import '../models/Project.dart';
import '../models/User.dart';

class Database {
  final CollectionReference projectsCollection = Firestore.instance.collection("projects");
  final CollectionReference usersCollection = Firestore.instance.collection("users");

  List<Task> convertToTask(String json) {
    List<Map<String, dynamic>> taskListData = (jsonDecode(json) as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();
    return taskListData.map((taskData) {
      return Task(id: taskData["id"], name: taskData["name"], description: taskData["description"], status: taskData["status"] as int);
    }).toList();
  }

  Future<List<Project>> getProjects() async {
    List<Document> projects = await projectsCollection.orderBy("createdAt", descending: true).get();
      return projects.map((doc) {
        var data = doc.map;
        return Project(
          id: doc.id,
          authorId: data["authorId"],
          name: data["authorId"],
          description: data["description"],
          tasks: convertToTask(data["tasks"]),
          dateTime: data["dateTime"],
          contributorsId: data["contributors"],
          bannerUrl: data["bannerUrl"]
        );
      }).toList();
  }

  Future<Project?> getProjectById(String projectId) async {
    try {
      DocumentReference projectSnapshot = projectsCollection.document(projectId);

      if (await projectSnapshot.exists) {
        Document document = await projectSnapshot.get();
        Map<String, dynamic> data = document.map;
        return Project(
          id: projectSnapshot.id,
          authorId: data["authorId"],
          name: data["name"],
          description: data["description"],
          tasks: convertToTask(data["tasks"]),
          dateTime: data["dateTime"],
          contributorsId: data["contributors"].cast<String>(),
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

  Future<Project> addProject(String authorId) async {
    try {
      Document doc = await projectsCollection.add({
        "authorId": authorId,
        "name": "",
        "description": "",
        "tasks": "[{}]",
        "dateTime": DateTime.now(),
        "contributors": [],
        "bannerUrl": ""
      });
      return Project(id: doc.id, authorId: authorId, name: "", description: "", tasks: [],  dateTime: DateTime.now(), contributorsId: [], bannerUrl: "");
    } catch (e) {
      return Project(id: "id", authorId: "authorId", name: "name", description: "description", tasks: [], dateTime: DateTime.now(), contributorsId: [], bannerUrl: "bannerUrl");
    }
  }

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
    List<Document> users = await usersCollection.where("email", isEqualTo: email).get();

    for(var doc in users){
      var data = doc.map;
      return User(
        id: doc.id,
        username: data["username"],
        avatarUrl: data["avatarUrl"],
        projectsIds: data["projectsIds"].cast<String>(),
        ownerProjectsIds: data["ownerProjectsIds"].cast<String>(),
      );
    }
    return null;
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