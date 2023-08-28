// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_manager/database/Database.dart';
import 'package:project_manager/models/Project.dart';
import 'package:project_manager/screens/dashboard.dart';
import 'package:project_manager/screens/project.dart';

class ProjectCard extends StatelessWidget {
  final String projectId;

  final DashboardPageState dashboard;

  List<List<Widget>> status = [
    [Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("In waiting", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))],
    [Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orangeAccent,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("In progress", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))],
    [Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green,),), Padding(padding: EdgeInsets.only(left: 5), child: Text("Completed", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),))],
  ];

  ProjectCard({super.key, required this.projectId, required this.dashboard});

  Future<Project> getProject() async {
    Database db = Database();
    Project project =  await db.getProjectById(projectId) as Project;

    return project;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: getProject(), builder: (context, data) {
      Project project = data.data as Project;
      double progressionValue = 0;
      List<Positioned> contributors = [];
      if(project.tasks.isNotEmpty){
        progressionValue = (100 * (project.tasksCompleted.length) / (project.tasks.length)) / 100;
      }else {
        progressionValue = 0;
      }

      double right = 0;
      project.contributorsId.map((user) {
        contributors.add(Positioned(width: 30, height: 30, bottom: 0, right: right, child: CircleAvatar(backgroundImage: AssetImage("assets/images/image.png"), backgroundColor: Colors.lightGreen, radius: 20,),));
        right += 20;
      });
      return MaterialButton(onPressed: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => ProjectPage(project: project))).then((value) {
              dashboard.setState(() {

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 11, child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.greenAccent]

                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 7, left: 7),
                          child: ClipRRect(borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                              child: LinearProgressIndicator(
                                value: progressionValue,
                                minHeight: 5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                                backgroundColor: Colors.transparent,
                              )),),
                        Expanded(child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  project.name,
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: status[project.status],
                                ),
                              ),
                            ),
                          ],
                        ),)
                      ]),
                ),), // Banner image, Project name, Status, Progress bar
                Expanded(flex: 12, child: Padding(padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(project.description, style: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Color(0xFFB0B0B0)),),
                      )),
                      Expanded(flex: 2, child: Container(
                        child: Row(
                          children: [
                            Expanded(child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text("${project.pendingTasks
                                                .length} pending tasks",
                                              style: TextStyle(
                                                  fontStyle: FontStyle
                                                      .normal),))
                                      ]),
                                  Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text("${project.currentTasks
                                                .length} current tasks",
                                                style: TextStyle(
                                                    fontStyle: FontStyle
                                                        .normal)))
                                      ]),
                                  Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                                "${project.tasksCompleted
                                                    .length} tasks completed",
                                                style: TextStyle(
                                                    fontStyle: FontStyle
                                                        .normal)))
                                      ]),
                                ],
                              ),
                            )), // Task manager
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Deadline: ${project.dateTime.toString()}",
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal)),
                                Expanded(child: Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: contributors,
                                )),
                              ],
                            )) // Limit date, members
                          ],
                        ),
                      ))
                    ],
                  ),
                )) // Description, Task, Limit date, Members
              ],
            )),
      );
    });
  }
}